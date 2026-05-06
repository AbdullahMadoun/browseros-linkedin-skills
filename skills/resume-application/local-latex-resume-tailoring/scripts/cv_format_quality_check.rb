#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "optparse"
require "fileutils"
require "open3"

PLACEHOLDER_RE = /\b(?:TODO|TBD|FIXME|Lorem ipsum|INSERT|REPLACE|placeholder)\b|<[^>\n]{2,80}>/i
DEFAULT_REQUIRED_SECTIONS = %w[summary education experience projects skills].freeze
SECTION_RE = /\\(?:section\*?|cvsection|resumesection|sectiontitle)\s*\{([^{}]+)\}/i

def read_file(path)
  raise ArgumentError, "missing file: #{path}" unless path && File.file?(path)

  File.read(path, encoding: "UTF-8")
end

def strip_comments(tex)
  tex.lines.map do |line|
    escaped = false
    out = +""
    line.each_char do |char|
      if char == "\\" && !escaped
        escaped = true
        out << char
        next
      end
      break if char == "%" && !escaped

      out << char
      escaped = false
    end
    out
  end.join
end

def latex_to_text(tex)
  text = strip_comments(tex).dup
  text.gsub!(/\\(textbf|textit|emph|href|url)\s*\{([^{}]*)\}/, ' \2 ')
  text.gsub!(/\\[a-zA-Z]+\*?(?:\[[^\]]*\])?(?:\{([^{}]*)\})?/, ' \1 ')
  text.gsub!(/[{}\\]/, " ")
  text.gsub!(/[$^~]/, " ")
  text.gsub!(/[[:space:]]+/, " ")
  text.strip
end

def words(text)
  text.scan(/[[:alnum:]][[:alnum:]+#.&'_-]*/)
end

def phrase_bolded?(phrase, candidate_bold)
  phrase_words = words(phrase.downcase)
  return false if phrase_words.empty?

  candidate_bold.any? do |bold|
    bold_words = words(bold.downcase)
    next false if bold_words.length < phrase_words.length

    bold_words.each_cons(phrase_words.length).any? { |slice| slice == phrase_words }
  end
end

def bold_phrases(tex)
  strip_comments(tex).scan(/\\textbf\s*\{([^{}]+)\}/).flatten.map do |phrase|
    latex_to_text(phrase).gsub(/\s+/, " ").strip
  end.reject(&:empty?)
end

def sections(tex)
  strip_comments(tex).scan(SECTION_RE).flatten.map do |section|
    latex_to_text(section).downcase.gsub(/[^a-z0-9 ]/, " ").split.join(" ")
  end
end

def section_bodies(tex)
  clean = strip_comments(tex)
  matches = clean.to_enum(:scan, SECTION_RE).map { Regexp.last_match }
  bodies = {}
  matches.each_with_index do |match, index|
    title = latex_to_text(match[1]).downcase.gsub(/[^a-z0-9 ]/, " ").split.join(" ")
    start_pos = match.end(0)
    end_pos = matches[index + 1]&.begin(0) || clean.length
    bodies[title] = latex_to_text(clean[start_pos...end_pos].to_s)
  end
  bodies
end

def suspicious_ampersand_lines(tex)
  in_alignment = false
  lines = []
  strip_comments(tex).lines.each_with_index do |line, index|
    in_alignment = true if line.match?(/\\begin\{(tabular|array|align|aligned)/)
    current_alignment = in_alignment
    in_alignment = false if line.match?(/\\end\{(tabular|array|align|aligned)/)
    next if current_alignment || !line.match?(/(^|[^\\])&/)

    lines << index + 1
  end
  lines
end

def pdf_page_count(pdf_path)
  return nil unless pdf_path && File.file?(pdf_path)

  stdout, _stderr, status = Open3.capture3("pdfinfo", pdf_path)
  return nil unless status.success?

  stdout[/^Pages:\s+(\d+)/, 1]&.to_i
rescue Errno::ENOENT
  nil
end

def quality_check(options)
  tex = read_file(options[:tex])
  baseline = options[:baseline] && File.file?(options[:baseline]) ? read_file(options[:baseline]) : nil
  text = latex_to_text(tex)
  word_count = words(text).length
  base_text = baseline ? latex_to_text(baseline) : nil
  baseline_words = base_text ? words(base_text).length : nil
  density_ratio = baseline_words && baseline_words.positive? ? (word_count.to_f / baseline_words).round(3) : nil
  tex_sections = sections(tex)
  bodies = section_bodies(tex)
  candidate_bold = bold_phrases(tex)
  baseline_bold = baseline ? bold_phrases(baseline) : []
  retained_bold = baseline_bold.select { |phrase| text.include?(phrase) }
  retained_still_bold = retained_bold.count { |phrase| phrase_bolded?(phrase, candidate_bold) }
  retained_bold_ratio = retained_bold.empty? ? nil : (retained_still_bold.to_f / retained_bold.length).round(3)
  bold_word_count = words(candidate_bold.join(" ")).length
  bold_word_ratio = word_count.positive? ? (bold_word_count.to_f / word_count).round(3) : 0.0
  page_count = pdf_page_count(options[:pdf])

  issues = []
  warnings = []

  issues << "candidate_tex_missing_document_begin" unless tex.include?("\\begin{document}")
  issues << "candidate_tex_missing_document_end" unless tex.include?("\\end{document}")

  required_sections = options[:required_sections]
  missing_sections = required_sections.reject do |required|
    tex_sections.any? { |section| section.include?(required) }
  end
  issues << "missing_required_sections: #{missing_sections.join(', ')}" if missing_sections.any?

  empty_sections = bodies.select { |_section, body| words(body).length < 8 }.keys
  issues << "empty_or_too_thin_sections: #{empty_sections.join(', ')}" if empty_sections.any?

  placeholders = tex.scan(PLACEHOLDER_RE).flatten.compact.uniq
  issues << "placeholder_markers_present: #{placeholders.join(', ')}" if placeholders.any?

  if baseline_words && density_ratio < options[:min_density_ratio]
    issues << "density_below_baseline: #{density_ratio} < #{options[:min_density_ratio]}"
  end

  if retained_bold.length >= 3 && retained_bold_ratio && retained_bold_ratio < options[:min_retained_bold_ratio]
    issues << "retained_bold_anchors_lost: #{retained_bold_ratio} < #{options[:min_retained_bold_ratio]}"
  end

  if candidate_bold.length < options[:min_bold_phrases]
    warnings << "low_bold_anchor_count: #{candidate_bold.length} < #{options[:min_bold_phrases]}"
  end

  warnings << "bolding_may_be_excessive: #{bold_word_ratio}" if bold_word_ratio > options[:max_bold_word_ratio]

  ampersand_lines = suspicious_ampersand_lines(tex)
  warnings << "suspicious_unescaped_ampersand_lines: #{ampersand_lines.join(', ')}" if ampersand_lines.any?

  if options[:pdf]
    if File.file?(options[:pdf])
      if page_count.nil?
        warnings << "pdf_page_count_unavailable"
      elsif page_count != options[:expected_pages]
        issues << "page_count_mismatch: #{page_count} != #{options[:expected_pages]}"
      end
    else
      issues << "pdf_missing: #{options[:pdf]}"
    end
  else
    warnings << "pdf_not_checked"
  end

  metrics = {
    word_count: word_count,
    baseline_word_count: baseline_words,
    density_ratio: density_ratio,
    section_count: tex_sections.length,
    sections: tex_sections,
    bold_phrase_count: candidate_bold.length,
    baseline_bold_phrase_count: baseline_bold.length,
    retained_bold_phrase_count: retained_bold.length,
    retained_bold_ratio: retained_bold_ratio,
    bold_word_ratio: bold_word_ratio,
    page_count: page_count
  }

  {
    pass: issues.empty?,
    tex: options[:tex],
    baseline: options[:baseline],
    pdf: options[:pdf],
    expected_pages: options[:expected_pages],
    issues: issues,
    warnings: warnings,
    metrics: metrics
  }
end

def write_report(report, out_path)
  return unless out_path

  FileUtils.mkdir_p(File.dirname(out_path))
  File.write(out_path, JSON.pretty_generate(report) + "\n")
end

def fixture_tex(summary:, education:, experience:, projects:, skills:, extra: "", section_command: "\\section*")
  <<~TEX
    \\documentclass[10pt]{article}
    \\usepackage[margin=0.55in]{geometry}
    \\usepackage{enumitem}
    \\setlist[itemize]{leftmargin=*, itemsep=1pt, topsep=1pt}
    \\begin{document}
    #{section_command}{Summary}
    #{summary}
    #{section_command}{Education}
    #{education}
    #{section_command}{Experience}
    #{experience}
    #{section_command}{Projects}
    #{projects}
    #{section_command}{Skills}
    #{skills}
    #{extra}
    \\end{document}
  TEX
end

def run_self_test(out_dir)
  FileUtils.rm_rf(out_dir)
  FileUtils.mkdir_p(out_dir)

  baseline = fixture_tex(
    summary: "Engineer focused on \\textbf{machine learning}, reliable automation, data workflows, and user-facing product quality.",
    education: "\\textbf{B.S. Computer Science}, strong coursework in algorithms, databases, systems, statistics, and applied AI.",
    experience: "\\begin{itemize}\\item Built \\textbf{Python} automation that reduced manual review time by 40 percent across recurring reports.\\item Shipped \\textbf{data pipelines} with validation checks, dashboards, and stakeholder-ready summaries.\\item Improved \\textbf{model evaluation} workflows by adding repeatable tests, error analysis, and release notes.\\end{itemize}",
    projects: "\\begin{itemize}\\item Created a \\textbf{retrieval system} with ranking experiments, quality metrics, and reproducible documentation.\\item Developed a \\textbf{web application} with authentication, API integration, and database-backed workflows.\\end{itemize}",
    skills: "\\textbf{Python}, SQL, machine learning, data analysis, automation, testing, Git, dashboards, APIs, LaTeX"
  )
  baseline_path = File.join(out_dir, "baseline.tex")
  File.write(baseline_path, baseline)

  fixtures = [
    ["run1_raw_placeholders.tex", fixture_tex(
      summary: "TODO tailor this resume for <target role>.",
      education: "",
      experience: "\\begin{itemize}\\item Did work with Python.\\end{itemize}",
      projects: "",
      skills: "Python"
    )],
    ["run2_structure_fixed_thin.tex", fixture_tex(
      summary: "Engineer focused on machine learning and automation.",
      education: "B.S. Computer Science with coursework in algorithms and statistics.",
      experience: "\\begin{itemize}\\item Built Python automation for recurring reports.\\end{itemize}",
      projects: "\\begin{itemize}\\item Created a retrieval system.\\end{itemize}",
      skills: "Python, SQL, machine learning"
    )],
    ["run3_density_fixed_bold_lost.tex", fixture_tex(
      summary: "Engineer focused on machine learning, reliable automation, data workflows, and product quality.",
      education: "B.S. Computer Science, strong coursework in algorithms, databases, systems, statistics, and applied AI.",
      experience: "\\begin{itemize}\\item Built Python automation that reduced manual review time by 40 percent across recurring reports.\\item Shipped data pipelines with validation checks, dashboards, and stakeholder-ready summaries.\\item Improved model evaluation workflows by adding repeatable tests, error analysis, and release notes.\\end{itemize}",
      projects: "\\begin{itemize}\\item Created a retrieval system with ranking experiments, quality metrics, and reproducible documentation.\\item Developed a web application with authentication, API integration, and database-backed workflows.\\end{itemize}",
      skills: "Python, SQL, machine learning, data analysis, automation, testing, Git, dashboards, APIs, LaTeX"
    )],
    ["run4_bold_fixed_escape_warning.tex", fixture_tex(
      summary: "Engineer focused on \\textbf{machine learning}, reliable automation, data workflows, and product quality.",
      education: "\\textbf{B.S. Computer Science}, strong coursework in algorithms, databases, systems, statistics, and applied AI.",
      experience: "\\begin{itemize}\\item Built \\textbf{Python automation} that reduced manual review time by 40 percent across recurring reports.\\item Shipped \\textbf{data pipelines} with validation checks, dashboards, and stakeholder-ready summaries.\\item Improved \\textbf{model evaluation} workflows by adding repeatable tests, error analysis, and release notes.\\end{itemize}",
      projects: "\\begin{itemize}\\item Created a \\textbf{retrieval system} with ranking experiments, quality metrics, and reproducible documentation.\\item Developed a \\textbf{web application} with authentication, API integration, and database-backed workflows.\\end{itemize}",
      skills: "\\textbf{Python}, SQL, machine learning, data analysis, automation, testing, Git, dashboards, APIs, LaTeX",
      extra: "Tools & platforms reviewed during final cleanup."
    )],
    ["run5_final_ready.tex", baseline.gsub(/\\section\*/, "\\cvsection")]
  ]

  rows = []
  fixtures.each_with_index do |(name, tex), index|
    tex_path = File.join(out_dir, name)
    report_path = File.join(out_dir, name.sub(/\.tex\z/, ".quality.json"))
    File.write(tex_path, tex)
    report = quality_check(
      tex: tex_path,
      baseline: baseline_path,
      pdf: nil,
      out: report_path,
      expected_pages: 1,
      min_density_ratio: 0.85,
      min_retained_bold_ratio: 0.8,
      min_bold_phrases: 3,
      max_bold_word_ratio: 0.18,
      required_sections: DEFAULT_REQUIRED_SECTIONS
    )
    write_report(report, report_path)
    rows << [index + 1, name, report[:pass], report[:issues], report[:warnings], report[:metrics]]
  end

  summary_path = File.join(out_dir, "summary.md")
  File.write(summary_path, +"# CV Format Quality Self-Test\n\n" \
    "| Run | Fixture | Pass | Issues | Warnings | Word Count | Bold Anchors |\n" \
    "|---|---|---|---|---|---:|---:|\n" +
    rows.map do |run, name, pass, issues, warnings, metrics|
      "| #{run} | #{name} | #{pass} | #{issues.join('; ')} | #{warnings.join('; ')} | #{metrics[:word_count]} | #{metrics[:bold_phrase_count]} |"
    end.join("\n") + "\n")

  {
    out_dir: out_dir,
    summary: summary_path,
    runs: rows.map do |run, name, pass, issues, warnings, metrics|
      {
        run: run,
        fixture: name,
        pass: pass,
        issues: issues,
        warnings: warnings,
        metrics: metrics
      }
    end
  }
end

options = {
  expected_pages: 1,
  min_density_ratio: 0.85,
  min_retained_bold_ratio: 0.8,
  min_bold_phrases: 3,
  max_bold_word_ratio: 0.18,
  required_sections: DEFAULT_REQUIRED_SECTIONS
}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: cv_format_quality_check.rb --tex FILE [--baseline FILE] [--pdf FILE] [--out FILE]"
  opts.on("--tex FILE", "Candidate LaTeX file") { |value| options[:tex] = value }
  opts.on("--baseline FILE", "Baseline LaTeX file for density and bolding comparison") { |value| options[:baseline] = value }
  opts.on("--pdf FILE", "Compiled PDF file to check page count") { |value| options[:pdf] = value }
  opts.on("--out FILE", "Write JSON report to FILE") { |value| options[:out] = value }
  opts.on("--expected-pages N", Integer, "Expected PDF page count") { |value| options[:expected_pages] = value }
  opts.on("--min-density-ratio N", Float, "Minimum candidate/baseline word ratio") { |value| options[:min_density_ratio] = value }
  opts.on("--min-retained-bold-ratio N", Float, "Minimum retained bold phrase ratio") { |value| options[:min_retained_bold_ratio] = value }
  opts.on("--min-bold-phrases N", Integer, "Minimum candidate bold phrase count") { |value| options[:min_bold_phrases] = value }
  opts.on("--max-bold-word-ratio N", Float, "Warn above this bold-word ratio") { |value| options[:max_bold_word_ratio] = value }
  opts.on("--required-sections x,y,z", Array, "Required section name substrings") { |value| options[:required_sections] = value.map(&:downcase) }
  opts.on("--allow-fail", "Exit 0 even when quality issues are found") { options[:allow_fail] = true }
  opts.on("--self-test DIR", "Write and run five fixture iterations in DIR") { |value| options[:self_test] = value }
end

parser.parse!

if options[:self_test]
  result = run_self_test(options[:self_test])
  puts JSON.pretty_generate(result)
  exit(result[:runs].last[:pass] ? 0 : 1)
end

unless options[:tex]
  warn parser
  exit 2
end

report = quality_check(options)
write_report(report, options[:out])
puts JSON.pretty_generate(report)
exit(report[:pass] || options[:allow_fail] ? 0 : 1)

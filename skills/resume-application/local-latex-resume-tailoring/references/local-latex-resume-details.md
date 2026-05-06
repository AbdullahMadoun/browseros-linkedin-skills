# Local LaTeX Resume Details

Load this reference for real tailoring runs, compile recovery, bolding audits,
or page-pressure fixes. The main `SKILL.md` carries routing and critical rules;
this file preserves execution detail without loading it for every trigger.

Sections: evidence/truth, bolding, skills policy, template preservation, compile
policy, role-family defaults, page pressure, rewrite planning, companion outputs,
format QA, and output folder contents.

## Evidence And Truth Policy

- Use `master_resume.json` as the preferred source of truth when available.
- If the user supplies a newer resume, richer bullets, or verified skills, update
  the master data rather than relying only on flat LaTeX.
- Do not invent tools, certs, metrics, employers, dates, responsibilities, or
  outcomes. Required-vs-preferred job requirements must be separated carefully.
- If a short role title is the only target, produce a first-pass role-prior
  tailoring and clearly mark that it is based on limited target evidence.
- If the role is ambiguous, ask one targeted question about direction.

## Bolding And Readability Policy

Bolding is part of communication quality, not decoration.

1. Preserve original bolding first. If an original bolded word or phrase survives
   in the tailored resume, keep it bold unless the content is removed, materially
   reworded away, or no longer truthful in context.
2. Carry emphasis through rewrites. If a rewritten bullet keeps the same metric,
   tool, method, domain, or outcome as the source bullet, transfer the original
   bold anchor to the closest equivalent wording.
3. Add selective bolding where it improves scanning. Each major section should
   contain truthful visual anchors when available: role-relevant tools, methods,
   domains, quantified outcomes, business results, awards, GPA, or high-signal
   keywords.
4. Be selective. Do not bold full bullets, long clauses, generic verbs, soft
   claims, unsupported job keywords, or filler. Prefer one to three short anchors
   per dense bullet and fewer when the line is simple.
5. Use bolding to reveal what matters: tool/method, scale/metric, technical or
   business result, domain, or role-relevant keyword.
6. Never use bolding to imply unsupported expertise.
7. Before final PDF, compare original vs tailored LaTeX and check retained bold
   phrases, new bold anchors, and section-level visual balance.

## Skills Section Policy

Allowed when truthful and role-applicable:

- reorder skills to match the target role
- expand the skills section with additional already-supported skills
- keep more skills when ATS coverage or role breadth benefits from them
- compress duplicate or low-signal skills when page pressure is high

Not allowed:

- adding unsupported skills to match keywords
- inflating familiarity into expertise
- copying job keywords with no resume/master evidence

## Template Preservation

Prefer a full standalone role-specific `.tex` that preserves section order,
spacing intent, header structure, visual density, and selective bolding.

Preferred order:

1. Start from the richer/original template when it compiles cleanly.
2. Use content substitutions, bullet swaps, ordering, and emphasis changes.
3. Keep `main.tex` fixed and inject generated content only if that is the local
   project pattern.
4. Switch to a simplified preamble only when compilation reliability requires it.

Do not redesign spacing or typography unless asked. Do not flatten icon/header
support or the bolding strategy just to make batch generation easier.

## Compile Policy

Probe compilers in this order:

1. `latexmk`
2. `xelatex`
3. `pdflatex`
4. `lualatex`
5. `tectonic`

Default behavior:

- Attempt PDF generation whenever a compiler exists.
- Prefer `latexmk -xelatex` for rich custom-font or icon templates.
- Prefer the simplest reliable local path over a fragile fancy template.
- Save `compile_report.json` on success and failure.
- Verify the expected PDF exists after compilation.
- Treat FontAwesome/logo/icon support as part of done when the source depends on
  it.

Compile recovery sequence:

1. Determine whether the failure is missing compiler, missing package, bad path,
   stale artifact, or LaTeX escaping.
2. If TinyTeX exists, use `tlmgr` to install missing packages.
3. Install custom font/icon dependency chains instead of silently dropping
   features.
4. Clear stale build artifacts before retrying.
5. With `latexmk`, force rebuild with `-g`.
6. Use absolute output directories to avoid nested-output bugs.
7. Check escaping for `&`, `%`, `_`, `#`, and similar characters.

Common TinyTeX packages:

- `titlesec`
- `enumitem`
- `newpx`
- `newtx`
- `fontawesome`
- `xstring`
- `mweights`
- `carlisle`
- `fontaxes`
- `kastrup`
- `oberdiek`

Validate icon commands such as `\faLinkedin` and `\faGithub` before considering
a rich header complete.

## Role-Family Defaults

Use these only when approved resume evidence supports them.

For AI/ML or research roles, emphasize model building, experimentation,
evaluation, optimization, testing/debugging, machine learning, computer vision,
NLP, retrieval, data modeling, research methods, publication-quality rigor, or
advanced coursework.

For data, analytics, or operations roles, emphasize metrics, analysis,
forecasting, dashboards, automation, operational decision support,
stakeholder-facing recommendations, and measurable process improvement.

For product, startup, or consulting roles, emphasize problem framing,
prioritization, customer/stakeholder understanding, product thinking,
structured execution, business impact, and supported cross-functional work.

For software engineering roles, emphasize languages, APIs, databases, testing,
version control, deployment, system-building, and shipping-oriented language.

## Page-Pressure Playbook

Assume one page by default.

1. Keep contact and header unchanged unless asked.
2. Prefer two bullets for each most relevant experience entry.
3. Usually keep one or two projects.
4. Collapse awards aggressively unless highly relevant.
5. Trim skills to role-relevant groups when needed, but keep additional truthful
   skills when ATS coverage or breadth meaningfully helps.
6. If compiled output spills, continue tightening until it fits.
7. Tighten margins first: low-value awards, low-value project bullets, redundant
   skills, and redundant wording before cutting strong evidence.
8. If the result is too sparse, restore high-signal original content and compress
   smarter.

## Format QA Gate

Use `references/cv-format-quality-loop.md` and
`scripts/cv_format_quality_check.rb` after material formatting changes and
before final delivery.

Minimum expected checks:

- candidate `.tex` has document boundaries
- required sections are present and not empty
- approximate word count is at least 85% of a strong baseline unless the user
  requested a lean resume
- retained baseline bold anchors remain bold when the phrase survives
- placeholders and draft markers are absent
- PDF page count is exactly one when a PDF was compiled and `pdfinfo` is
  available; otherwise record the warning and verify the compile report or PDF
  manually

Save the JSON output as `format_quality_report.json`. Treat issues as blockers
unless the user explicitly changed the target, such as asking for a short CV,
two-page academic CV, or partial snippet.

## Reviewable Rewrite Planning

For exact-substring rewrites:

- Account for one source line or bullet at a time.
- `original_text` must be an exact substring from the source LaTeX.
- Proposed text must preserve facts and LaTeX structure.
- Prefer fewer high-value rewrites over forcing edits everywhere.
- For applied-draft review, compare original vs accepted draft and classify the
  result as improved, mixed, unchanged, or worse with concrete reasons.

## Companion Outputs

Cover letter body:

- short, specific, value-led
- grounded in resume and alignment analysis
- no unsupported project details or inflated claims

Company research:

- compact Markdown briefing
- culture, recent news, interview style, employee sentiment, likely technical or
  business context

Interview prep:

- role-specific talking points
- likely questions
- honest red flags
- exact numbers worth memorizing

## Typical Output Folder

Use:

`<local-browseros-runs-dir>/resume_local_tailoring/output/<role-slug>/`

Typical files:

- `job.txt`
- `job_summary.txt`
- `parsed_job_requirements.json`
- `alignment_analysis.json`
- `selection_report.json`
- `rewrite_plan.json`
- `ApplicantName_role.tex`
- `ApplicantName_role.pdf`
- `compile_report.json`
- `format_quality_report.json`
- `cover_letter_body.json`
- `company_research.md`
- `interview_prep.json`
- `applied_draft_review.json`

When you discover a recurring local build fix, update workspace docs or helper
scripts so the next run is simpler.

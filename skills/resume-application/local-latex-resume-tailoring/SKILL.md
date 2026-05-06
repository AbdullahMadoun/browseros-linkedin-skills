---
name: local-latex-resume-tailoring
description: >-
  Tailor a resume fully locally using structured master resume data,
  deterministic selection, reviewable rewrites, and local LaTeX/PDF compilation.
  Also supports adjacent application workflows such as job parsing, alignment
  review, cover-letter drafting, company research, and interview prep.
metadata:
  display-name: Local LaTeX Resume Tailoring
  enabled: "true"
  version: "1.5"
---

# Local LaTeX Resume Tailoring

## Purpose

Create factual, role-specific resume artifacts locally: parsed job requirements,
alignment analysis, selected content, reviewable rewrites, LaTeX, PDF when a
compiler exists, and optional cover letter/interview/company notes.

Use this skill for local resume tailoring, ATS/recruiter alignment, LaTeX resume
compilation, one custom resume per role, and grounded adjacent application
outputs. For multi-role shortlist batches, pair with
`linkedin-shortlist-resume-batch-tailoring`.

## Critical Rules

1. Keep the workflow fully local whenever possible.
2. Never invent skills, tools, metrics, employers, titles, dates, degrees,
   certifications, outcomes, or contact/header details.
3. Use approved evidence first: `master_resume.json`, current LaTeX resume,
   user-provided updates, and prior user-approved additions.
4. Every resume output is exactly one page unless the user explicitly changes
   the page target. A thin one-page resume is still a failure.
5. Preserve the original resume's density, structure, sendability, and selective
   bolding. Change content only when it improves truth-preserving role fit,
   clarity, ordering, or emphasis.
6. Do not treat the skills section as trim-only. Reorder or expand with
   already-supported skills when useful; never add unsupported keywords.
7. Prefer exact, reviewable edits. For rewrite plans, every `original_text` must
   be copied exactly from the LaTeX source.
8. Compile to PDF when a local compiler exists, verify the PDF exists, and save
   a compile report. If compilation is blocked, still produce the tailoring
   artifacts and explain the blocker.

For detailed execution rules, load
`references/local-latex-resume-details.md` when working on any real resume run,
compile failure, bolding audit, or page-pressure fix.

For final format QA, repeated format repair, or regression testing, load
`references/cv-format-quality-loop.md` and run
`scripts/cv_format_quality_check.rb` against the candidate `.tex`, baseline
`.tex`, and PDF when available.

## Primary Assets

Prefer project-local or user-provided assets:

- `current_resume.tex`
- `current_resume_rich.tex`
- `master_resume.json`
- `tailor_resume.py`
- `bootstrap_latex_resume.sh`
- `WORKFLOW_PROMPT_GUIDE.md`

Use a per-target workspace such as:

`<local-browseros-runs-dir>/resume_local_tailoring/output/<role-slug>/`

If the user provides new verified resume material, update the master JSON or
source-of-truth notes instead of relying only on flat LaTeX.

## Workflow

1. **Ingest target.** Save the role/JD as `job.txt`; if long, create a compact
   `job_summary.txt` without losing high-signal requirements.
2. **Parse requirements.** Extract company, title, seniority, required and
   preferred skills, responsibilities, industry keywords, soft skills,
   education, experience years, culture signals, and keyword taxonomy. Separate
   required vs preferred carefully; use empty values when evidence is missing.
3. **Score approved content only.** Rank summary fragments, skills, and bullets
   from the approved source of truth by overlap with the role's wording and
   intent.
4. **Analyze alignment.** Review every section and bullet. Score keyword match,
   evidence quality, relevance, and overall fit; mark each bullet `strong`,
   `adequate`, or `weak` with a truthful improvement idea for non-strong items.
5. **Choose strategy before rewriting.** Decide what stays prominent, what gets
   tightened, which bullets deserve rewrites, and what must be preserved for
   density or one-page quality.
6. **Assemble the resume.** Start from the strongest existing full resume shape,
   preserve header/contact, template rhythm, section presence, and high-signal
   content. Use substitutions, bullet swaps, ordering, and selective emphasis
   before structural reduction.
7. **Audit bolding and density.** Retained original bold phrases stay bold.
   Rewritten achievements carry equivalent truthful emphasis. Add sparse anchors
   for tools, methods, metrics, domains, outcomes, GPA, or high-signal role
   keywords when supported.
8. **Compile and verify.** Probe compilers in this order: `latexmk`, `xelatex`,
   `pdflatex`, `lualatex`, `tectonic`. Prefer `latexmk -xelatex` for rich
   custom-font/icon templates. Confirm the final PDF exists.
9. **Run format QA.** Use `scripts/cv_format_quality_check.rb` to check
   document structure, density against baseline, retained bold anchors,
   placeholders, section content, and PDF page count when a PDF exists.
10. **Record outputs.** Save audit artifacts so selection, rewrites, compile,
   format QA, and final readiness are inspectable.

## Page And Density Guardrails

- Default target is one page for simple, rich, original, tailored, and final
  accepted variants.
- If the result spills, tighten low-value awards, project bullets, redundant
  skills, wording, and spacing before removing high-signal evidence.
- If the result becomes sparse, restore stronger original content and find a
  smarter compression path.
- Use approximate plain-text word count as a secondary check against the strong
  baseline resume. Investigate outputs below roughly 85% of the baseline unless
  the user asked for a lean version.

## Output Contract

Typical per-role artifacts:

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
- optional `cover_letter_body.json`, `company_research.md`,
  `interview_prep.json`, `applied_draft_review.json`

Use stable exported names such as `ApplicantName_role.pdf`; sanitize role names
with underscores and remove unsafe punctuation.

## Adjacent Outputs

When requested, generate grounded companion artifacts from the same evidence:

- short, specific cover letter body
- compact company/interview brief
- likely role-specific questions and honest risk notes
- applied-draft review that judges whether accepted edits improved the resume

## Success Criteria

The run is successful when the resume is factual, visibly role-aligned,
substantial, exactly one page, locally reproducible, selectively bolded, passes
format QA or has documented exceptions, and compiles to a real PDF whenever a
compiler is available. Rich/icon variants must compile when explicitly
requested or the missing dependency must be documented.

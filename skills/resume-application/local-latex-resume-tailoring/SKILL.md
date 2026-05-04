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
  version: "1.3"
---

# Local LaTeX Resume Tailoring

## Purpose

Run a fully local, auditable resume tailoring workflow that can:

- tailor a resume to a role
- generate a real PDF locally
- analyze job requirements
- score resume-to-job alignment
- propose reviewable line-by-line rewrites
- review an applied draft after user choices
- generate a grounded cover letter body
- prepare compact company research and interview notes

## Primary assets

Use project-local or user-provided assets first.

Recommended names:

- `current_resume.tex`
- `current_resume_rich.tex`
- `master_resume.json`
- `tailor_resume.py`
- `bootstrap_latex_resume.sh`
- `WORKFLOW_PROMPT_GUIDE.md`

Recommended workspace pattern:

`<local-browseros-runs-dir>/resume_local_tailoring/`

If the user provides a newer resume, richer bullets, or additional verified skills, update the master JSON rather than relying only on flat LaTeX.

Use the current user-approved header/contact source. Do not invent or change email, phone, location, links, or header details unless the user explicitly asks.

## When to use

Activate when the user asks to:

- tailor a resume to a job description
- adapt a resume for a specific role
- optimize a resume for ATS or recruiter review
- compile a LaTeX resume or produce a PDF locally
- generate a grounded cover letter from the same evidence base
- prepare interview notes, company research, or draft review artifacts from the tailored resume workflow
- keep all application processing local and auditable

If the user is working from a multi-role shortlist file and wants one custom resume per opportunity, pair or defer to `linkedin-shortlist-resume-batch-tailoring`.

## Operating principles

1. Keep the workflow fully local whenever possible.
2. Never invent skills, tools, metrics, employers, titles, dates, degrees, certifications, or outcomes.
3. Prefer abstaining over guessing.
4. Preserve LaTeX structure exactly when a workflow depends on string replacement.
5. Review every bullet when doing alignment analysis.
6. The user controls which suggested edits are accepted; propose improvements aggressively but truthfully.
7. Store per-role outputs in their own folder.
8. Keep an audit artifact showing why content was selected or changed.
9. If a local compiler is missing, still complete the tailoring workflow and report the compile blocker clearly.
10. Every resume output is subject to a hard one-page rule unless the user explicitly changes the page target.
11. Preserve the original resume's density, structure, and sendability; do not hollow out the document just to make tailoring easy.
12. Use a word-count safety check so an output cannot quietly become too short while still fitting on one page.
13. Preserve original bolded words and phrases whenever the underlying content remains present.
14. Add selective bolding throughout every tailored resume output to improve readability, but only on truthful high-signal anchors.

## Hard one-page rule

Default behavior is exactly one page.

- This applies to every variant: simple, rich, original, tailored, and final accepted resumes.
- Do not accept a two-page result as "good enough".
- If content pressure is too high, tighten, reorder, compress, or remove lower-value material until the resume fits exactly one page.
- One page is necessary but not sufficient: an underfilled, obviously thinned-out, or low-signal resume is also a failure.
- Preserve truth first, then preserve the original resume's strength and density, then satisfy the page target.

## Word-count safety rule

Use word count as a secondary guardrail.

- Measure the generated resume's approximate plain-text word count.
- Compare it against the original strong baseline resume, not against an arbitrary universal number.
- If the generated resume falls materially below the baseline, treat it as suspect even if it still fits on one page.
- A practical default is to investigate outputs below roughly 85% of the original rich resume baseline unless the user explicitly asks for a leaner version.
- Word count does not override truth or one-page limits, but it helps prevent hollow one-page outputs.

## Supported workflow families

### A. Tailored Resume Generation

Use deterministic ranking and selection from the approved master resume to produce a role-specific LaTeX resume and PDF.

### B. Strict Alignment Analysis

Evaluate the resume against a job posting section by section and bullet by bullet. Find meaningful improvement opportunities instead of giving only high-level feedback.

### C. Exact-Substring Rewrite Planning

When producing reviewable replacement suggestions, each `original_text` must be copied exactly from the LaTeX source, with one source line or bullet accounted for at a time.

### D. Applied-Draft Review

After user selections are applied, compare the accepted draft against the original and judge whether it truly improved.

### E. Adjacent Application Outputs

Generate grounded companion artifacts from the same evidence base:

- cover letter body
- company research brief
- interview prep notes
- compact job summary

## Input contract

Minimum useful inputs:

- a role title or full job description
- the current LaTeX resume or master resume JSON

Preferred inputs:

- target company name
- job description text
- constraints such as one page, ATS-heavy, research-heavy, product-heavy, consulting-heavy, or internship-focused
- user guidance on rewrite aggressiveness or section emphasis

## Workflow architecture

### 1. Ingest The Target

Save the target role locally.

Suggested naming:

- `job.txt` for ad hoc runs
- `jobs/<role-or-company-slug>.txt` for repeatable runs

If the posting is long or noisy, also create a compact `job_summary.txt` that preserves only the highest-signal requirements and duties.

### 2. Parse Job Requirements

Extract a structured requirement object from the posting.

Minimum fields to preserve when possible:

- company
- title
- seniority
- required skills
- preferred skills
- responsibilities
- industry keywords
- soft skills
- education
- experience years
- culture signals
- keyword taxonomy

Rules:

- false positives are worse than omissions
- required vs preferred must be separated carefully
- use empty strings or arrays when evidence is missing
- do not infer tools, certs, or years of experience from company or industry alone

### 3. Score Approved Content Only

Use `master_resume.json` as the approved source of truth when available.

Rank:

- summary fragments
- skills
- bullets within experience, project, and award sections

Prefer high overlap with the target role's wording and intent.

### 4. Run Alignment Analysis

For each resume section, score:

- keyword match
- evidence quality
- relevance
- overall section score

Every bullet must receive a review verdict:

- `strong`
- `adequate`
- `weak`

For `adequate` and `weak`, provide a concrete truthful improvement idea.

### 5. Decide Strategy Before Rewriting

Before changing text, decide:

- what sections should stay prominent
- what should be tightened or de-emphasized
- which bullets are highest-value rewrite targets
- what rewrite coverage is worth attempting

Prefer improving the highest-value truthful subset of bullets over forcing edits everywhere.

### 6. Assemble Tailored Content

Generate role-specific content while preserving factual integrity:

- concise summary when useful
- reordered experience emphasis
- top bullets per experience
- optional inclusion or exclusion of projects and awards based on relevance and page pressure
- tailored skills ordering and coverage

Default preservation rule:

- start from the strongest existing full resume shape, not from a minimal skeleton
- keep most of the original template and most high-signal content
- preserve every original bolded word or phrase when its surrounding content remains in the tailored resume
- when rewriting a sentence that retains the same achievement, tool, metric, or outcome, carry forward the original bold emphasis unless it would become inaccurate or awkward
- add new selective bolding where it improves skimmability and first-read comprehension
- change only what adds role fit, clarity, ordering, or emphasis
- do not remove content unless it clearly improves relevance or is necessary to preserve one-page quality
- a tailored resume should still look sendable and substantial, not sparse

## Skills policy

Do not treat the skills section as trim-only.

Allowed when truthful and role-applicable:

- reorder skills to match the target role
- expand the skills section with additional already-supported skills from the approved source of truth
- keep more skills when ATS coverage or role breadth benefits from them
- compress duplicate or low-signal skills when page pressure is high

Not allowed:

- adding unsupported skills just to match keywords
- inflating familiarity into expertise
- copying job keywords that are not evidenced by the resume or approved source material

## Preserve Layout And Emphasis

Prefer generating a full standalone role-specific `.tex` that preserves the existing section order, spacing intent, header structure, overall visual density, and selective bolding emphasis of the original resume.

Preferred approach:

- start from the richer/original template when it compiles cleanly
- keep the same visual rhythm, section presence, and substantial feel of the original resume
- maintain original `\textbf{...}` emphasis on metrics, tools, technical phrases, and result-heavy fragments whenever those words or phrases remain in the output
- prefer content substitutions, bullet swaps, and emphasis changes over structural reduction

### Bolding and readability policy

Bolding is part of the resume's communication quality, not decoration. Apply this policy to every generated or rewritten `.tex` resume:

1. **Preserve original bolding first.** If an original bolded word or phrase survives in the tailored resume, keep it bold unless the content is removed, materially reworded away, or no longer truthful in context.
2. **Carry emphasis through rewrites.** If a rewritten bullet keeps the same metric, tool, method, domain, or outcome as the source bullet, transfer the original bold anchor to the closest equivalent wording.
3. **Add selective bolding where it helps scanning.** Each major section should contain clear visual anchors when truthful anchors are available: role-relevant tools, methods, domains, quantified outcomes, business results, awards, GPA, or high-signal keywords.
4. **Be selective, not noisy.** Do not bold full bullets, long clauses, generic verbs, soft claims, unsupported job keywords, or ordinary filler. Prefer 1-3 short bold anchors per dense bullet and fewer when the line is already simple.
5. **Use bolding to reveal structure.** Good anchors usually answer one of: what tool/method, what scale/metric, what business or technical result, what domain, what role-relevant keyword.
6. **Never use bolding to imply unsupported expertise.** A bolded term must be grounded in the approved resume/master evidence, not copied from the job description for ATS appearance.
7. **Audit before final PDF.** Before compiling or finalizing, compare original vs tailored LaTeX and check that retained original bold phrases are still bold, new bolding is sparse and meaningful, and no section looks visually flat.

Fallback approaches:

- replace only content sections in a copied role-specific `.tex`
- keep `main.tex` fixed and inject `generated_content.tex`
- switch to a simplified preamble only when compilation reliability truly requires it

Do not redesign spacing or typography unless the user asks, do not butcher the template just to make batch generation easier, and do not flatten the original bolding strategy into plain text unless a specific change genuinely improves the resume.

## Local compiler policy

Probe for compilers in this order:

1. `latexmk`
2. `xelatex`
3. `pdflatex`
4. `lualatex`
5. `tectonic`

Recommended mode:

- for rich custom-font templates, prefer `latexmk -xelatex` when available
- for the simplest reliable local path, prefer a dependency-light template and compile with `latexmk -pdf`
- otherwise compile with the best available local engine
- if no compiler exists, do not block the workflow; generate LaTeX artifacts and report the missing dependency clearly

### Compile Locally To PDF

Default behavior: when a local compiler is available, compile the tailored resume all the way to a final named PDF unless the user explicitly asks for LaTeX-only output.

Required PDF behavior:

- attempt PDF generation whenever a compiler exists
- prefer the simplest reliable path over the fanciest template if compilation is fragile
- save a compile report whether compilation succeeds or fails
- verify that the expected PDF file actually exists after compilation
- treat icon/logo support as part of done when the source resume depends on FontAwesome or similar packages

### Output Naming Convention

Default exported resume names should follow a stable applicant/role pattern.

- Prefer `ApplicantName_role.pdf` or the user's approved naming convention.
- Sanitize the role into a filename-safe form using underscores instead of spaces and removing unsafe punctuation.
- Use the same stem for the LaTeX source when useful, e.g. `ApplicantName_role.tex`.
- The folder can still be role-based, but the exported resume filename itself should remain stable and readable.

### Compile Recovery Playbook

If local compilation fails, use this sequence instead of guessing:

1. check whether the failure is a missing compiler or a missing package
2. if TinyTeX exists, use `tlmgr` to install missing package(s)
3. if the template depends on custom font/icon packages, install the dependency chain rather than silently dropping features
4. clear stale build artifacts before retrying
5. when using `latexmk`, force a rebuild with `-g`
6. use absolute output directories to avoid nested-output bugs
7. verify LaTeX escaping logic when failures involve characters like `&`, `%`, `_`, or `#`

### Common TinyTeX Packages For Resume Templates

Common packages for compact resume templates include:

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

The simple path often depends mainly on `titlesec` and `enumitem`. Richer templates may require font and icon packages. Validate icon commands such as `\faLinkedin` and `\faGithub` before considering a rich header complete.

## Optional companion outputs

When the user asks for them, generate these from the same grounded evidence base:

### Cover Letter

Write a short, specific, value-led cover letter body grounded only in the resume and alignment analysis.

### Company Research

Produce a compact Markdown interview briefing focused on culture, recent news, interview style, employee sentiment, and likely technical or business context.

### Interview Prep

Generate talking points, likely role-specific questions, honest red flags, and exact numbers worth memorizing.

### Applied Draft Review

After edits are accepted or rejected, compare original vs accepted draft and judge whether the draft is improved, mixed, unchanged, or worse.

## Role-family positioning rules

Use these as defaults only when the approved resume evidence supports them.

### For AI/ML Or Research Roles

Emphasize:

- model building, experimentation, evaluation, optimization, testing, and debugging
- relevant machine learning, computer vision, NLP, retrieval, or data modeling work
- research methods, publication-quality rigor, or advanced coursework when supported by the resume

### For Data / Analytics / Operations Roles

Emphasize:

- metrics, analysis, forecasting, dashboards, automation, or operational decision support
- stakeholder-facing recommendations
- measurable impact from process improvement or analytical work

### For Product / Startup / Consulting Roles

Emphasize:

- problem framing, prioritization, customer or stakeholder understanding
- product thinking, structured execution, and business impact
- cross-functional collaboration where supported by resume evidence

### For Software Engineering Roles

Emphasize:

- programming languages, APIs, databases, testing, version control, deployment, and system-building work
- shipping-oriented language over purely academic language

## Page-pressure rules

Assume one page by default.

1. Keep contact and header unchanged unless asked.
2. Prefer 2 bullets for each most relevant experience entry.
3. Usually keep 1-2 projects maximum.
4. Collapse awards aggressively unless highly relevant.
5. Trim skills to the most role-relevant groups when needed, but keep additional truthful skills when ATS coverage or breadth meaningfully helps.
6. If the compiled result spills beyond the page target, continue tightening until it fits.
7. Tighten from the margins first: trim low-value awards, low-value project bullets, or redundant skills before stripping the resume down to something visually weak.
8. If the result becomes too sparse, restore stronger original content and find a smarter compression path.

## Suggested output structure

Use a per-target folder like:

`<local-browseros-runs-dir>/resume_local_tailoring/output/<role-slug>/`

Typical contents:

- `job.txt`
- `job_summary.txt`
- `parsed_job_requirements.json`
- `alignment_analysis.json`
- `selection_report.json`
- `rewrite_plan.json`
- `ApplicantName_role.tex`
- `ApplicantName_role.pdf`
- `compile_report.json`
- `cover_letter_body.json`
- `company_research.md`
- `interview_prep.json`
- `applied_draft_review.json`

## Execution notes

- If the user gives only a short role title, still run a first-pass tailoring based on role priors.
- If the user gives a full JD, prioritize explicit wording from the JD.
- If multiple roles are requested, generate one output folder per role.
- If the role is ambiguous, ask one targeted question about target direction.
- Save a compile report whenever compilation is attempted, even on success.
- Name each exported resume using the approved naming convention before considering the run complete.
- When you discover a recurring local build fix, update workspace docs or helper scripts so the next run is simpler.
- Use `WORKFLOW_PROMPT_GUIDE.md` as the canonical high-level prompt/stage reference when it exists.

## Success criteria

This skill succeeds when:

- the tailored resume is factual
- the role alignment is obvious on first read
- original bolded phrases that remain in the content are still bolded
- new bolding is selectively added across the resume to make key evidence easier to scan without visual clutter
- every resume output meets the page target
- the output is locally reproducible
- the workflow produces a real PDF when a compiler is available, not just a `.tex` file
- rich/icon variants compile when explicitly requested
- the selection and rewrite logic is inspectable afterward
- adjacent outputs remain grounded in the same approved evidence base

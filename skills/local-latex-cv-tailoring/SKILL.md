---
name: local-latex-cv-tailoring
description: >-
  Tailor Abdullah Madoun's CV fully locally using structured master CV data,
  deterministic bullet selection, and local LaTeX compilation. Use when the user
  asks to tailor a CV to a job description, optimize for a role, generate a
  tailored LaTeX/PDF resume, or automate local CV customization.
metadata:
  display-name: Local LaTeX CV Tailoring
  enabled: "true"
  version: "1.0"
---

# Local LaTeX CV Tailoring

## Purpose

Produce a tailored CV fully locally, with a transparent selection process and optional local PDF compilation.

## Primary assets

Use these assets first if they exist:

- `/Users/abdullah/Desktop/BroswerOS/runs/cv_local_tailoring/abdullah_current_cv.tex`
- `/Users/abdullah/Desktop/BroswerOS/runs/cv_local_tailoring/abdullah_master_cv.json`
- `/Users/abdullah/Desktop/BroswerOS/runs/cv_local_tailoring/tailor_cv.py`

If the user provides a newer CV or more bullets, update the master JSON rather than relying only on the flat LaTeX source.

## When to use

Activate when the user asks to:

- tailor their CV to a job description
- adapt their resume for a specific role
- automate resume customization locally
- compile a LaTeX resume after role-based edits
- keep all resume processing local and auditable

## Operating principles

1. Keep the workflow fully local.
2. Do not invent achievements, metrics, employers, dates, or technologies.
3. Prefer deterministic selection, ranking, and trimming over freeform rewriting.
4. Preserve the existing LaTeX layout unless the user explicitly asks for redesign.
5. Store per-role outputs in their own folder.
6. Keep an audit artifact showing why bullets were selected.
7. If a local compiler is missing, still complete the tailoring and leave compile instructions.

## Input contract

Minimum useful inputs:

- a role title or a full job description
- the current LaTeX CV or master CV JSON

Preferred inputs:

- target company name
- job description text
- constraints such as one page, ATS-heavy, research-heavy, product-heavy, consulting-heavy, or internship-focused

## Local compiler policy

Probe for compilers in this order:

1. `latexmk`
2. `xelatex`
3. `pdflatex`
4. `lualatex`
5. `tectonic`

Recommended mode:

- prefer `latexmk -xelatex` when available
- otherwise compile with the best available local engine
- if no compiler exists, do not block the tailoring workflow; generate LaTeX artifacts and report the missing dependency clearly

## Tailoring method

### 1. Ingest the target

Create a local text file for the target role if one is not already present.

Suggested naming:

- `job.txt` for ad hoc runs
- `jobs/<role-or-company-slug>.txt` for repeatable runs

### 2. Extract demand signals

From the target role, extract and normalize:

- role title terms
- domain terms
- required tools and methods
- business verbs such as built, optimized, analyzed, automated, delivered
- soft constraints such as stakeholder-facing, research-heavy, experimentation, product sense, operations, consulting, or dashboards

### 3. Score approved content only

Use `abdullah_master_cv.json` as the approved source of truth.

Rank:

- summary fragments
- skills
- bullets within each experience/project/award section

Prefer high overlap with the target role's terms and intent.

### 4. Assemble a tailored content block

Generate role-specific content while preserving factual integrity:

- concise summary
- trimmed and reordered skills
- top bullets per experience
- optional inclusion or exclusion of projects and awards depending on relevance and page pressure

### 5. Preserve layout

For Abdullah's current CV, prefer generating a full standalone role-specific `.tex` that preserves the existing preamble, spacing, section style, and header format.

Fallback approaches:

- replace only content sections in a copied role-specific `.tex`
- or keep `main.tex` fixed and inject `generated_content.tex`

Do not redesign spacing or typography unless the user asks.

### 6. Compile locally if possible

If a compiler exists, compile and save the PDF into the per-role output folder.

### 7. Save artifacts

Always save:

- tailored `.tex`
- selected content report in JSON or markdown
- job description snapshot
- compile report if compilation was attempted

## Abdullah-specific positioning rules

Use these as defaults unless the target role strongly suggests otherwise.

### For AI/ML or research roles

Emphasize:

- end-to-end computer vision pipeline work
- few-shot classification design
- model evaluation, optimization, testing, and debugging
- tabular ML performance and ensemble work
- sign language research with TCNs, Transformers, and GNNs
- strong GPA and AI specialization when useful

De-emphasize if space is tight:

- generic awards not related to ML, unless they add prestige

### For data / analytics / operations roles

Emphasize:

- fraud risk metric across operational tables
- semantic text-matching automation
- Power BI KPI dashboards
- root-cause analysis and forecasting support
- practical automation that reduced manual work
- stakeholder-facing recommendations and operational visibility

De-emphasize if space is tight:

- deep research-model details that do not translate to business value

### For product / startup / consulting roles

Emphasize:

- PitchSwipe product concept and recommendation engine
- Four Principles consulting competition and transformation roadmap
- cross-functional framing, problem-solving, and structured execution
- ability to connect technical work to business outcomes

### For SWE roles

Emphasize:

- Python, Java, SQL, FastAPI, Docker, REST APIs, Git, CI/CD, testing, Linux
- end-to-end system building aspects of research projects
- shipping-oriented language over purely academic language

## Page-pressure rules

For one-page targets:

1. Keep contact and header unchanged unless asked.
2. Prefer 2 bullets for each most relevant experience entry.
3. Usually keep 1-2 projects maximum.
4. Collapse awards aggressively unless highly relevant.
5. Trim skills to the most role-relevant groups rather than dumping the full list.

## Suggested output structure

Use a per-target folder like:

`/Users/abdullah/Desktop/BroswerOS/runs/cv_local_tailoring/output/<role-slug>/`

Typical contents:

- `job.txt`
- `selection_report.json`
- `generated_content.tex`
- `tailored_cv.tex`
- `tailored_cv.pdf`
- `compile_report.json`

## Execution notes

- If the user gives only a short role title, still run a first-pass tailoring based on role priors.
- If the user gives a full JD, prioritize explicit wording from the JD.
- If multiple roles are requested, generate one output folder per role.
- If the role is ambiguous, ask one targeted question about the target direction.

## Success criteria

This skill succeeds when:

- the tailored CV is factual
- the role alignment is obvious on first read
- the output is locally reproducible
- the result can compile locally when a compiler is available
- the selection logic is inspectable afterward

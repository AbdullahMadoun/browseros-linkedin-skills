---
name: linkedin-shortlist-resume-batch-tailoring
description: >-
  Turn a ranked shortlist of LinkedIn or similar job opportunities into one
  truthful, one-page custom resume per opportunity, then audit outputs for
  unsupported facts and generate a clear job-to-resume mapping guide.
metadata:
  display-name: LinkedIn Shortlist Resume Batch Tailoring
  enabled: "true"
  version: "1.1"
---

# LinkedIn Shortlist Resume Batch Tailoring

## Purpose

Use this skill when the user has a shortlist file containing many role opportunities and wants a custom resume for each one without losing factual integrity.

This skill captures a reusable workflow for batch-generating custom resumes from a ranked job shortlist.

## When to use

Activate when the user asks to:

- create many custom resumes from one shortlist file
- tailor one resume per LinkedIn post opportunity or contact lead
- mass-produce role-specific resumes from a ranked list
- batch-generate one-page resumes and keep them organized
- audit a batch for hallucinations or unsupported facts
- create a job-to-resume mapping guide for later outreach or application work

## Expected input shape

Best input is a markdown or text file where each opportunity includes most of:

- rank or priority
- job title
- location
- fit notes
- contact route
- source link or source context
- caveat such as seniority mismatch

If the file lacks full job descriptions, use the fit notes and title as the tailoring target.

## Privacy and safety

- Treat the shortlist, resume source, contact routes, source links, exported filenames, and mapping guide as sensitive.
- In chat summaries, use rank numbers or redacted labels unless the user asks for full opportunity details.
- Do not expose raw personal contact details in logs unless the user explicitly asks.
- Use generic applicant naming in examples and templates.

## Hard rules

1. No lying. Never invent skills, tools, metrics, employers, titles, dates, degrees, certifications, or outcomes.
2. Every resume must be exactly one page unless the user explicitly changes the page target.
3. Every final exported resume should follow a stable convention such as `ApplicantName_role.pdf` or a user-approved naming pattern.
4. Duplicate titles across different opportunities must still remain distinguishable through rank-specific folders, manifests, and mapping guides.
5. Batch convenience must never override factual integrity.
6. Batch speed must not hollow out the resume; every output must still look substantial and sendable.
7. Track word count for every generated resume and flag outputs that fall materially below the original strong baseline.
8. Preserve useful selective bolding so the batch outputs do not become visually bland.

## Core workflow

### 1. Ingest and normalize the shortlist

Read the shortlist file and create a normalized internal record for each opportunity.

Minimum fields to preserve per item:

- rank
- title
- tier or priority if present
- contact route
- fit notes
- source link or source context
- caveat if present

### 2. Create one target file per opportunity

For each role, create a local `job.txt` that includes:

- target role title
- fit notes
- any caveats
- source link or source context
- tailoring instructions such as one-page enforcement and truth-only constraints

If a full JD is unavailable, treat the fit notes as the best available target signal.

### 3. Classify the role family before tailoring

Use role-family heuristics to decide what evidence to prioritize and how aggressively to trim.

Useful families:

- `ai_ml`
- `data_engineering`
- `analytics`
- `bi`
- `business`
- `general`

Examples:
- AI Engineer / Data Scientist / Data and AI Engineer -> `ai_ml`
- Data Engineer / Data Management Engineer -> `data_engineering`
- Data Analyst / Analytics Engineer / Data Operations Specialist -> `analytics`
- BI Developer -> `bi`
- Business Analyst / Performance Analyst -> `business`

### 4. Tailor conservatively, then tighten iteratively

Start from the approved source-of-truth resume data and generate a role-specific resume.

Default preservation rule:

- start from the strongest approved resume shape, not a minimal shell
- keep most of the original template and high-signal content
- keep useful selective bolding patterns on metrics, tools, outcomes, and high-signal phrases
- change what adds role fit; do not remove content casually
- a one-page resume should still feel full, credible, and sendable

Use family-aware trimming rules such as:

- AI/ML roles: keep the strongest research/ML evidence and usually 1-2 projects
- data engineering roles: keep SQL/Python/pipeline evidence and trim awards first
- analytics / BI roles: prioritize reporting, SQL, dashboards, KPI, root-cause, and forecasting evidence
- business/performance roles: emphasize KPI analysis, reporting, decision support, stakeholder-facing work, and operational recommendations

If the compiled PDF exceeds one page:

1. remove awards first unless they clearly help
2. reduce projects to the most relevant 1 or 0
3. reduce project bullets before experience bullets
4. reduce lower-value experience bullets only after less critical sections are compressed
5. keep the strongest relevant evidence, not the maximum amount of evidence
6. if the result becomes obviously too short or weak, restore stronger original content and find a better compression path

### 5. Export with strict naming

For each opportunity:

- keep a rank-specific folder for organization
- export final files using the approved applicant/role stem
- prefer filenames like `ApplicantName_Data_Analyst_Riyadh.pdf`
- optionally mirror the same stem in `.tex`

Important:
- folders may be rank-specific even when filenames repeat across opportunities with the same role title
- the mapping guide must resolve ambiguity when filenames repeat

### 6. Validate one-page status and word-count safety

Do not assume success from compilation alone.

Verify page count for each compiled PDF. If the PDF is longer than one page, continue tightening and recompile until it fits.

Also verify a word-count floor:

- compute approximate plain-text words for each resume
- compare against the original strong baseline resume
- if a resume falls materially below the baseline, flag it as too thin even if page count is correct
- a practical default is to investigate outputs below roughly 85% of the original rich resume baseline

### 7. Run a post-generation truth audit

Audit each exported `.tex` or equivalent source against the approved master resume.

Check for unsupported:

- bullets
- company names
- role titles
- dates
- project names
- award names
- skills
- languages

The batch is not complete until unsupported-fact findings are zero or explicitly resolved.

### 8. Generate a job-to-resume mapping guide

Always produce a mapping artifact so the user can later apply or message contacts without confusion.

Recommended guide fields:

- rank
- tier
- exact job title
- contact route type
- fit focus
- exported PDF filename
- folder path
- status
- page count

Provide both:

- a readable markdown guide
- a machine-friendly CSV guide

## High-value insights from this workflow

### Insight 1: Batch tailoring works best with role-family presets

When full JDs are absent, role-family classification plus fit notes is enough to produce smart first-pass tailoring without hallucination.

### Insight 2: One-page enforcement should be iterative, not aspirational

Do not just ask for one page and hope. Compile, check page count, tighten, and recompile.

### Insight 3: A truth audit is a first-class step, not a nice-to-have

Batch resume work creates many outputs quickly. A final unsupported-fact audit is what keeps scale from degrading integrity.

### Insight 4: Mapping guides prevent later operational mistakes

When titles repeat, the user needs a stable crosswalk from role/contact/rank to the correct resume file.

### Insight 5: Rank-specific folders are useful even when final filenames follow a stable applicant/role pattern

This preserves a preferred naming convention while still avoiding confusion in multi-role batches.

## Recommended artifacts

For a batch root folder, save:

- `manifest.json`
- `batch_report.md`
- `hallucination_audit.json`
- `hallucination_audit.md`
- `job_to_resume_mapping_guide.md`
- `job_to_resume_mapping_guide.csv`
- one subfolder per ranked opportunity

For each opportunity subfolder, save:

- `job.txt`
- compile artifacts
- final role-specific `.tex`
- final role-specific `.pdf`

## Success criteria

This skill succeeds when:

- every opportunity gets a role-specific resume
- every final resume is exactly one page unless otherwise requested
- no unsupported facts appear in the batch audit
- exported files follow the approved naming convention
- duplicate-title roles are still easy to distinguish through the mapping guide
- the user can immediately tell which resume belongs to which job

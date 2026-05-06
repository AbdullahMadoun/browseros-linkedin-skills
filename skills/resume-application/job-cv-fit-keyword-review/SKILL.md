---
name: job-cv-fit-keyword-review
description: >-
  Review one or more jobs, LinkedIn posts, recruiter posts, or job descriptions
  against a CV/resume by extracting requirements, mapping evidence, scoring fit,
  checking ATS keyword coverage, flagging unsupported or stuffed keywords, and
  recommending honest next actions.
metadata:
  display-name: Job CV Fit And Keyword Review
  enabled: "true"
  version: "1.0"
---

# Job CV Fit And Keyword Review

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this as the canonical fit-review skill. It replaces separate job-fit ranking and ATS keyword-density review workflows.

The goal is candid prioritization and truthful tailoring: decide whether a role is worth applying to, what evidence supports the fit, which keywords are missing or weak, and what must not be invented.

## Use When

- ranking jobs, LinkedIn jobs, recruiter posts, or hiring posts by CV/resume fit
- checking one job description against a CV/resume
- reviewing ATS keyword coverage or stuffing risk
- deciding whether to apply, tailor first, network first, clarify, save, or skip
- producing a shortlist before CV tailoring, outreach, or application work

Pair with:

- `lead-scoring-dedup-pivots` when raw leads need dedupe, recency/contact scoring, or pivot planning.
- `local-latex-resume-tailoring` when a promising role should become a tailored one-page PDF.
- `resume-hallucination-risk-audit` when generated or edited material may contain unsupported claims.

## Hard Rules

- Use only the CV/resume or explicitly approved candidate source.
- Never invent tools, certifications, employers, titles, dates, degrees, metrics, work authorization, or years of experience.
- Separate required criteria from preferred/contextual terms.
- Treat LinkedIn and recruiter posts as noisy; mark vague requirements as uncertain.
- Do not add a keyword unless it is supported by candidate evidence.
- Do not optimize by repetition; recruiter readability beats density.

## Input Model

Minimum:

- job description, LinkedIn job/post, recruiter post, or shortlist
- CV/resume text, PDF-extracted text, LaTeX, or approved master profile

Optional:

- user constraints: geography, work authorization, salary, remote/hybrid, role-family preference, stretch-role appetite
- output preference: quick verdict, ranked table, JSON, or tailoring notes

## Workflow

### 1. Normalize Opportunity

For each opportunity, preserve only observed data:

- title, company, source URL, poster/recruiter, posted date, location, work mode
- application/contact route
- raw text used for scoring
- missing fields as `unknown`

Deduplicate by URL, company/title, recruiter/poster, or near-identical text before ranking.

### 2. Extract Requirements

Classify:

- required skills and qualifications
- preferred skills
- responsibilities
- tools/platforms/frameworks
- domain terms and industry keywords
- education, certifications, years, seniority
- logistics: location, language, work mode, authorization, travel
- soft skills/culture signals

Required means explicit must-have wording or central repeated responsibility. If unclear, mark preferred or contextual.

### 3. Map CV Evidence

Build an evidence map:

- explicit skills/tools
- roles, employers, projects, and education
- domain experience
- responsibilities and ownership
- metrics and outcomes exactly present
- strongest supporting bullets or lines

Equivalent wording may count only when the link is direct and defensible. Exact tools/certifications/degrees need exact evidence.

### 4. Score Fit

Default 100-point model:

| Dimension | Weight |
|---|---:|
| Required requirement match | 35 |
| Responsibility/domain relevance | 25 |
| Evidence quality | 20 |
| Preferred/soft/culture fit | 10 |
| Logistics/application signal | 10 |

If logistics are unavailable, redistribute that weight across the first four dimensions.

Use caps to avoid inflated scores:

- missing mandatory certification/license: cap 60
- missing mandatory degree/field: cap 65 unless equivalent experience is accepted and evidenced
- years/seniority mismatch: cap 70, or 55 for severe mismatch
- missing central mandatory tool/hard skill: cap 70, or 60 if core to the role
- clear location/authorization impossibility: cap 65 unless user says otherwise
- vague post with weak requirements: cap 80

Verdicts:

- `Excellent fit`: 85-100
- `Strong fit`: 75-84
- `Viable fit`: 65-74
- `Stretch fit`: 50-64
- `Weak fit`: below 50

### 5. Review Keyword Coverage

For important job terms, label:

- `well_covered`
- `underrepresented`
- `missing_but_supported`
- `missing_and_unsupported`
- `weakly_evidenced`
- `overused`

Use this density guide:

- 0 occurrences: add only if required and supported
- 1-2 occurrences: usually healthy
- 3+ occurrences: stuffing risk unless naturally spread across distinct evidence

Recommend at most five safe keyword improvements. If a term is unsupported, say not to add it.

## Output

For one role:

```text
Verdict:
Score:
Why:
Strongest CV evidence:
Main gaps:
Keyword coverage:
Stuffing or unsupported-keyword risks:
Safe tailoring moves:
Next action:
```

For multiple roles:

```text
Rank | Score | Verdict | Company | Title | Source | Best evidence | Gaps | Keyword notes | Next action
```

When saving structured outputs, use fields:

- rank, score, verdict
- company, title, source_url
- required_match_summary
- strongest_evidence
- missing_or_risky_requirements
- keyword_coverage_summary
- caps_or_penalties
- recommended_next_action
- discarded_or_duplicates

## Quality Check

Before final output:

- every requirement came from the job source
- every match came from CV/approved evidence
- hard blockers are capped and explained
- missing supported keywords are distinguished from unsupported terms
- advice helps truthful tailoring without encouraging fake claims


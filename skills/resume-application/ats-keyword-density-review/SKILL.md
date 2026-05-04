---
name: ats-keyword-density-review
description: >-
  Review a resume or tailored resume for ATS keyword coverage, missing job terms,
  natural keyword density, and keyword-stuffing risk while preserving factual
  integrity.
metadata:
  display-name: ATS Keyword Density Review
  enabled: 'true'
  version: '1.0'
---

# ATS Keyword Density Review

## Purpose

Use this skill to evaluate whether a resume naturally covers the important keywords from a job posting without stuffing, exaggeration, or unsupported claims.

The goal is not to maximize keyword count. The goal is to make truthful, recruiter-readable, ATS-friendly evidence easier to find.

## When to use

Activate when the user asks to:

- check ATS fit
- review keyword coverage
- identify missing job keywords
- see whether a tailored resume is keyword-stuffed
- improve resume keywords without lying
- compare a resume against a job description for ATS optimization
- decide which job terms are worth adding, avoiding, or leaving out

## Inputs

Minimum useful inputs:

- job description or parsed job requirements
- resume, resume text, or LaTeX resume

Optional inputs:

- approved skills/profile/vault source
- target role family
- existing alignment analysis
- user preference for conservative or aggressive keyword tuning

## Hard rules

1. Never recommend adding a keyword unless it is supported by the resume or approved source.
2. Separate required keywords from preferred/nice-to-have terms.
3. Exact tools, certifications, licenses, platforms, languages, and degrees require exact evidence.
4. Do not treat keyword repetition as quality.
5. Do not copy job-description phrasing verbatim into the resume.
6. Warn when a keyword is present but weakly evidenced.
7. Preserve readability and professional tone over raw ATS density.

## Keyword taxonomy

Classify target terms into:

- hard skills
- tools/platforms/frameworks
- certifications/licenses
- domain knowledge
- responsibilities/duties
- soft skills/culture signals
- education/years/seniority
- logistics/language/location if relevant

## Density model

For each target keyword or phrase:

- `0 occurrences` → high review priority if required and supported somewhere in the candidate source.
- `1-2 occurrences` → usually healthy; add only if a stronger natural evidence placement exists.
- `3+ occurrences` → stuffing risk; do not add more unless the term is central and repeated naturally across distinct evidence.

Occurrence count alone is not enough. Also assess:

- placement: summary, skills, experience, projects, education
- evidence strength: named deliverable, tool, metric, ownership, domain context
- naturalness: whether the line reads like a human resume bullet
- specificity: exact tool/cert vs broad category

## Output schema

Recommended output:

```json
{
  "overall_verdict": "strong | adequate | weak | risky",
  "summary": "short candid assessment",
  "keyword_coverage": [
    {
      "keyword": "",
      "category": "hard_skill | tool | certification | domain | responsibility | soft_skill | education | logistics",
      "priority": "required | preferred | contextual",
      "occurrences": 0,
      "status": "well_covered | underrepresented | missing_but_supported | missing_and_unsupported | overused | weakly_evidenced",
      "evidence_locations": ["section or bullet reference"],
      "recommendation": "keep | add_once | strengthen_evidence | do_not_add | reduce_repetition",
      "safe_wording_idea": "truthful phrasing suggestion or empty"
    }
  ],
  "missing_required_keywords": [""],
  "unsupported_keywords_to_avoid": [""],
  "stuffing_risks": [""],
  "best_safe_edits": ["max 5 practical keyword improvements"]
}
```

## Review method

1. Parse the job requirements and preserve canonical spellings/acronyms.
2. Count target keywords in the resume case-insensitively, while also checking close variants.
3. Map every apparent match to actual resume evidence.
4. Label each keyword as well-covered, underrepresented, missing but supported, missing and unsupported, overused, or weakly evidenced.
5. Recommend only natural additions that improve evidence clarity.
6. If no safe insertion exists, say so instead of forcing a keyword.

## Good recommendations

Good:

- `Add SQL once in the Experience bullet that already describes database reporting, because SQL is required and the resume supports it elsewhere.`
- `Do not add AWS. The posting requires AWS, but the resume does not evidence it.`
- `Reduce repeated 'analytics' wording in the summary; keep it in Skills and the strongest dashboard bullet.`

Bad:

- `Add Kubernetes to match the posting` when Kubernetes is not in the resume.
- `Repeat Python in every section for ATS.`
- `Rewrite the bullet by copying the exact job requirement sentence.`

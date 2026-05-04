---
name: linkedin-job-resume-fit-ranking
description: >-
  Rank LinkedIn job postings or hiring posts by fit against a provided resume for any
  role family, using strict requirement extraction, evidence-only resume matching,
  candid scoring, and optional user-facing feedback on gaps and next actions.
metadata:
  display-name: LinkedIn Job Resume Fit Ranking
  enabled: 'true'
  version: '1.0'
---

# LinkedIn Job Resume Fit Ranking

## Purpose

Use this skill to rank LinkedIn job postings, hiring posts, recruiter posts, or job-description snippets by how well they fit a candidate's resume.

The workflow is general for any role. Do not hardcode assumptions for data, AI, software, business, or any other field. Extract requirements from the posting first, then score only against evidence present in the resume or an explicitly approved candidate profile/vault.

## When to use

Activate when the user asks to:

- rank LinkedIn jobs by resume fit
- score a LinkedIn job posting against their resume
- decide which jobs from LinkedIn are worth applying to
- compare multiple LinkedIn postings, recruiter posts, or job links
- give feedback on why a role is a strong, weak, or stretch fit
- identify resume gaps or tailoring opportunities for a LinkedIn job
- produce a ranked shortlist before tailoring resumes or outreach messages

Pair with:

- `lead-scoring-dedup-pivots` when raw search results need deduplication, recency/contact scoring, or pivot planning.
- `linkedin-shortlist-resume-batch-tailoring` when the ranked shortlist should become one tailored resume per opportunity.
- `local-latex-resume-tailoring` when the user wants a full resume rewrite, PDF, cover letter, or interview prep after ranking.

## Core principles

1. **No invention.** Never invent skills, experience, employers, titles, degrees, certifications, metrics, dates, locations, work authorization, or tools.
2. **False positives are worse than omissions.** If the posting is vague, mark the requirement as ambiguous or preferred rather than required.
3. **Use resume evidence only.** A requirement counts as matched only when it is clearly evidenced in the provided resume or approved candidate source.
4. **Score fit, not polish.** A well-written resume with weak role overlap should not receive a high fit score.
5. **Separate must-have from nice-to-have.** Required criteria drive ranking more than preferred criteria.
6. **Prefer candid feedback.** The user benefits more from honest gaps and next actions than inflated encouragement.
7. **Generalize by extracting role needs.** Do not assume technologies, certifications, seniority, or years from the company, industry, or title alone.
8. **Treat LinkedIn content as noisy.** Hiring posts may be informal, incomplete, duplicated, or written by recruiters; preserve uncertainty.

## Inputs

Minimum useful inputs:

- one or more LinkedIn job postings, URLs, copied job descriptions, or hiring-post snippets
- candidate resume text, LaTeX, PDF-extracted text, or approved master profile

Optional inputs:

- target geography, visa/work authorization constraints, salary preferences, remote/hybrid preferences
- role-family preferences or exclusions
- user's appetite for stretch roles
- whether to optimize for application priority, networking priority, or resume-tailoring potential

## Output artifacts for substantial runs

When ranking multiple postings, save reusable outputs in the workspace when possible:

- `ranked_linkedin_jobs.md` — readable shortlist with feedback
- `ranked_linkedin_jobs.csv` — machine-friendly table
- `ranked_linkedin_jobs.json` — full extracted requirements and scoring details

Recommended columns:

- rank
- fit_score
- verdict
- title
- company
- LinkedIn/source URL
- seniority
- location/logistics
- required_match_summary
- strongest_resume_evidence
- missing_or_risky_requirements
- feedback_for_user
- recommended_next_action

## Workflow

### 1. Normalize each LinkedIn opportunity

For each posting, preserve:

- source URL if available
- post or job title
- company if explicit
- poster/recruiter if relevant
- posted date or recency signal if visible
- location, remote/hybrid, relocation, or work authorization signals
- application/contact route
- raw text used for scoring

Do not fill missing fields from outside assumptions. Use empty strings or `unknown` where evidence is absent.

### 2. Extract job requirements with high precision

Create a structured requirement object for each posting:

```json
{
  "company": "company name if explicit, else empty",
  "title": "job title if explicit, else empty",
  "seniority": "entry | mid | senior | lead | unknown",
  "required_skills": ["hard skills clearly required"],
  "preferred_skills": ["nice-to-have skills"],
  "responsibilities": ["key duties, max 8"],
  "industry_keywords": ["domain terms and acronyms"],
  "soft_skills": ["explicit or strongly signaled soft skills"],
  "education": "degree or field requirement if stated, else empty",
  "experience_years": "years required if stated, else empty",
  "certifications": ["required or preferred certifications"],
  "logistics": ["location, onsite, language, travel, work authorization"],
  "culture_signals": ["values, work style, team signals"],
  "keyword_taxonomy": {
    "hard_skills": ["technical or functional capabilities"],
    "tools": ["software, platforms, frameworks, equipment"],
    "certifications": ["licenses or certs"],
    "domain_knowledge": ["industry or business-domain phrases"]
  }
}
```

Extraction rules:

- Treat an item as **required** only when the post uses must-have language, states a direct qualification, or makes it central to core responsibilities.
- If unclear, place it in `preferred_skills` or `industry_keywords`, not `required_skills`.
- Normalize duplicates while preserving the employer's meaning.
- Keep requirement items concise.
- Preserve canonical spellings and important acronyms.
- Do not infer years, certifications, degrees, or tools from title or company alone.
- Seniority mapping:
  - intern, junior, associate → `entry`
  - intermediate, mid-level → `mid`
  - senior → `senior`
  - lead, staff, principal, head → `lead`
  - unclear → `unknown`

### 3. Extract candidate evidence from the resume

Build an evidence map from the resume or approved candidate source:

```json
{
  "skills": ["explicit skills/tools"],
  "roles": ["titles and employers"],
  "domain_experience": ["domains actually evidenced"],
  "responsibilities": ["duties and ownership evidenced"],
  "metrics": ["numbers and outcomes exactly present"],
  "certifications": ["certifications exactly present"],
  "education": ["degrees/fields exactly present"],
  "locations_languages": ["only if stated"],
  "strong_bullets": ["best supporting bullets or lines"]
}
```

Rules:

- If a skill, tool, certification, years-of-experience claim, or metric is not in the resume/approved source, treat it as missing.
- Equivalent wording can count only when the relationship is direct and defensible. Example: `stakeholder reporting` may support `executive reporting` only if stakeholder/executive context is actually present.
- Do not award credit for generic similarity when a required tool/certification is explicit.

### 4. Score resume fit

Score each posting from 0 to 100 using this default model:

| Dimension | Weight | What to assess |
|---|---:|---|
| Required requirement match | 35% | Must-have skills, core qualifications, required tools/certs/degrees/years |
| Responsibility/domain relevance | 25% | Whether resume bullets show similar work, domain, ownership, and scope |
| Evidence quality | 20% | Specific deliverables, outcomes, metrics, named tools, clear ownership |
| Preferred/culture/soft fit | 10% | Nice-to-haves, collaboration style, communication, domain extras |
| Logistics and application signal | 10% | Location, remote/onsite, work authorization, recency/contact clarity when relevant |

If the task is purely resume-to-JD fit and logistics are unavailable, redistribute logistics weight proportionally across the first four dimensions.

#### Dimension rubrics

Required requirement match:

- 90-100: Nearly all critical required criteria are directly evidenced.
- 70-89: Most required criteria are evidenced; one or two important gaps.
- 50-69: Partial coverage; several required gaps or one major uncertain requirement.
- 30-49: Minimal must-have overlap.
- 0-29: Almost no required overlap.

Responsibility/domain relevance:

- 90-100: resume shows highly similar duties, domain, ownership, and stakeholders.
- 70-89: Similar work is present with moderate scope or domain gaps.
- 50-69: Some adjacent evidence, but role would require repositioning.
- 30-49: Mostly tangential experience.
- 0-29: Responsibilities do not map to resume evidence.

Evidence quality:

- 90-100: Evidence includes specific deliverables, tools, metrics, scope, and outcomes.
- 70-89: Good evidence but limited metrics or scale.
- 50-69: Generic accomplishments with some relevant terms.
- 30-49: Duty-only wording with weak proof.
- 0-29: Vague or unsupported claims.

Preferred/culture/soft fit:

- Score only what the posting actually asks for and the resume actually supports.
- Do not let soft skills compensate for missing hard must-haves.

Logistics/application signal:

- Score visible fit for location, remote/onsite, work authorization, language, travel, recency, and contact clarity.
- If a logistics requirement is absent from both posting and user preferences, mark unknown rather than penalizing heavily.

### 5. Apply caps and penalties for hard mismatches

Use caps to prevent inflated scores:

- Missing explicit mandatory certification/license: cap at 60 unless the resume has equivalent official evidence.
- Missing explicit mandatory degree/field: cap at 65 unless the role says equivalent experience accepted and the resume supports it.
- Required years substantially exceed evidenced seniority: cap at 70; cap at 55 for severe mismatch.
- Seniority mismatch:
  - user appears under target seniority by one level: cap at 75
  - under by two or more levels: cap at 60
  - user appears overqualified for explicitly junior/intern role: cap at 75 unless user says that is acceptable
- Missing core tool or hard skill repeated throughout the posting: cap at 70; cap at 60 if it is central and mandatory.
- Explicit location/work authorization mismatch: cap at 65; cap lower only if the user confirms it is impossible.
- Vague/incomplete LinkedIn post: cap at 80 unless enough requirements are present to score confidently.

Always explain any cap in the feedback.

### 6. Assign verdicts

Use these labels:

- `Excellent fit` — 85-100: Apply or prioritize immediately; resume likely needs only targeted tailoring.
- `Strong fit` — 75-84: Worth applying; a few gaps or tailoring needs.
- `Viable fit` — 65-74: Reasonable but competitive; tailor carefully or network first.
- `Stretch fit` — 50-64: Apply only if strategically valuable; major gaps need honest handling.
- `Weak fit` — below 50: Usually deprioritize unless the user has external context not in the resume.

### 7. Rank multiple postings

Sort by:

1. fit_score descending
2. fewer hard blockers
3. stronger required-skill coverage
4. stronger evidence quality
5. better logistics/contact clarity
6. recency and source confidence

Deduplicate before final ranking when entries share the same company, title, recruiter, URL, or nearly identical text. Keep the version with the clearest requirements and application route.

## Feedback to provide when asked

When the user asks for feedback, be candid and specific. Do not provide generic encouragement.

Recommended structure:

```text
Verdict: Strong fit (78/100)
Why: The resume clearly supports X, Y, and Z, which map to the role's core requirements.
Main gaps: A and B are required/preferred in the posting but not evidenced in the resume.
Risk: The role asks for N years / certification / seniority; the resume only supports ...
How to tailor: Emphasize these existing resume bullets/skills; do not add unsupported claims.
Next action: Apply now / tailor resume first / message recruiter / deprioritize.
```

Feedback categories:

- **Strongest matches:** top 3 pieces of resume evidence that justify the score.
- **Missing requirements:** important posting requirements not found anywhere in the resume.
- **Weak evidence:** requirements that appear adjacent but not strongly proven.
- **Tailoring opportunities:** truthful ways to surface existing evidence more clearly.
- **Dealbreakers or caps:** certifications, years, location, work authorization, or seniority issues.
- **Questions to clarify:** only ask when a missing fact could materially change the score.
- **Application recommendation:** apply, tailor first, network first, save for later, or skip.

## Output schema for ranked jobs

For machine-readable output, use:

```json
{
  "ranked_jobs": [
    {
      "rank": 1,
      "fit_score": 0,
      "verdict": "Excellent fit | Strong fit | Viable fit | Stretch fit | Weak fit",
      "company": "",
      "title": "",
      "source_url": "",
      "seniority": "entry | mid | senior | lead | unknown",
      "parsed_requirements": {},
      "dimension_scores": {
        "required_match": 0,
        "responsibility_domain_relevance": 0,
        "evidence_quality": 0,
        "preferred_culture_soft_fit": 0,
        "logistics_application_signal": 0
      },
      "caps_or_penalties": [""],
      "strongest_matches": [""],
      "missing_from_resume": [""],
      "weak_or_adjacent_evidence": [""],
      "tailoring_opportunities": [""],
      "feedback_for_user": "",
      "recommended_next_action": "apply | tailor_first | network_first | clarify | save_for_later | skip"
    }
  ],
  "discarded_or_duplicates": [
    {
      "source_url": "",
      "reason": "duplicate | too vague | low fit | logistics mismatch | other"
    }
  ]
}
```

## Quality checklist

Before reporting results:

- Did every required skill come from explicit posting language or a core responsibility?
- Did every claimed match come from explicit resume evidence?
- Are required and preferred criteria separated?
- Are hard blockers capped rather than hidden inside an optimistic score?
- Is the feedback actionable without encouraging the user to invent facts?
- Are vague LinkedIn posts marked as uncertain rather than over-scored?
- For multiple jobs, are duplicates removed and ranking tie-breakers applied?

## Examples of grounded feedback

Good feedback:

- `Strong fit because the resume directly supports stakeholder reporting, SQL analysis, dashboard delivery, and KPI tracking. Main gap: the post asks for Salesforce, which is not evidenced, so the score is capped below excellent.`
- `Stretch fit: the role centers on licensed clinical practice, and the resume does not show the required license. Do not apply unless the candidate has that license outside the current resume and can verify it.`
- `Viable fit: the resume shows adjacent project coordination and analytics evidence, but the posting emphasizes enterprise change management. Tailor by surfacing stakeholder-facing delivery and measurable outcomes already present.`

Bad feedback:

- Do not say `great fit` just because titles sound similar.
- Do not suggest adding Python, AWS, PMP, CPA, RN, or any other credential unless it is already evidenced.
- Do not hide a missing mandatory requirement inside generic advice like `highlight transferable skills`.

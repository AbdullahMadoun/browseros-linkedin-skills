---
name: resume-hallucination-risk-audit
description: >-
  Audit a tailored resume, resume draft, cover letter, or application text against an
  original resume and approved source material to find unsupported facts, truth
  stretches, and risky claims.
metadata:
  display-name: Resume Hallucination Risk Audit
  enabled: 'true'
  version: '1.0'
---

# Resume Hallucination Risk Audit

## Purpose

Use this skill to verify that application materials remain truthful after tailoring. It checks whether edited resumes, cover letters, summaries, or interview notes introduced unsupported skills, tools, certifications, employers, titles, dates, degrees, metrics, outcomes, or claims of ownership.

This is the standalone truth-audit skill to use when the user asks whether a draft is safe, honest, or grounded.

## When to use

Activate when the user asks to:

- check a tailored resume for hallucinations
- audit unsupported claims
- verify that edits are truthful
- compare original resume vs edited resume
- check if a cover letter added claims not in the resume
- identify truth-stretch risk before applying
- review whether a resume rewrite invented anything

## Inputs

Minimum useful inputs:

- original resume or approved candidate profile/vault
- edited resume, tailored resume, cover letter, or application text

Optional inputs:

- job description or parsed job requirements
- list of accepted/rejected changes
- master resume JSON
- prior alignment analysis
- user-approved additional facts

## Hard rules

1. Treat the original resume and approved vault as the only source of truth.
2. User-provided new facts count only if clearly stated as true and approved for use.
3. Never assume a tool, certification, employer, metric, degree, or date from context.
4. A role keyword appearing in the job description is not evidence that the candidate has it.
5. Do not rewrite the whole resume during audit unless the user asks; focus on risk detection and safe alternatives.
6. Prefer false alarms over missed unsupported claims, but label uncertainty clearly.

## Entity categories to audit

Check for unsupported or changed:

- hard skills and tools
- platforms, frameworks, programming languages, software, equipment
- certifications, licenses, clearances
- employers, clients, institutions
- job titles, seniority, dates, durations
- degrees, majors, education claims
- projects, products, systems, datasets
- metrics, percentages, counts, scale, money, user numbers
- outcomes and impact claims
- ownership verbs such as led, owned, architected, managed, delivered
- domain claims such as finance, healthcare, logistics, government, SaaS
- location, language, work authorization, travel availability

## Risk levels

- `high` — direct unsupported factual claim, fake certification/tool/metric/title/employer, or major scope inflation.
- `medium` — possibly true but not evidenced, stronger ownership than source supports, ambiguous domain/tool equivalence.
- `low` — wording could be interpreted too broadly but is mostly grounded.
- `safe` — clearly supported by the source.

## Output schema

Recommended output:

```json
{
  "verdict": "safe | mostly_safe | risky | unsafe",
  "headline": "short candid summary",
  "risk_summary": "2-3 sentence explanation",
  "unsupported_claims": [
    {
      "claim": "exact claim from edited text",
      "category": "skill | tool | certification | employer | title | date | degree | metric | outcome | ownership | domain | logistics | other",
      "risk_level": "high | medium | low",
      "why_risky": "what is unsupported or overstated",
      "source_evidence_found": "quote or reference from original source, or empty",
      "safe_replacement": "grounded alternative wording or empty"
    }
  ],
  "changed_facts": [
    {
      "original": "",
      "edited": "",
      "risk_level": "high | medium | low",
      "note": ""
    }
  ],
  "safe_strong_claims": ["claims that are strong and well supported"],
  "recommended_actions": ["fix, verify with user, remove, or keep"]
}
```

## Audit method

1. Extract factual entities from the edited material.
2. Extract factual entities from the original resume and approved source material.
3. Compare exact and defensible equivalents.
4. Flag any edited claim that lacks source support.
5. Pay special attention to numbers and credentials; these require exact support.
6. Check ownership verbs:
   - `led` requires evidence of leadership or ownership.
   - `built` requires evidence of direct creation.
   - `managed` requires evidence of management responsibility.
   - `architected` requires strong design/architecture evidence.
7. Provide a safer replacement when possible, using only supported wording.

## Safe audit feedback examples

Good:

- `Unsafe: the edited resume adds AWS and Kubernetes, but neither appears in the source resume or approved vault. Remove both unless the user explicitly verifies them.`
- `Medium risk: 'led migration' is stronger than the source bullet, which only says the candidate contributed to migration support. Safer wording: 'Supported migration...'`
- `Safe: the 85% improvement metric appears in the original resume and can remain.`

Bad:

- `Probably fine because it is common for this role.`
- `Keep the certification because the job asks for it.`
- `Add a small metric to make it stronger.`

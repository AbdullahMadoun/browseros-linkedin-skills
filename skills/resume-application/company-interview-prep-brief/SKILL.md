---
name: company-interview-prep-brief
description: >-
  Combine compact company research with grounded interview prep: culture,
  recent news, interview signals, talking points, likely questions, red flags,
  and resume evidence to use.
metadata:
  display-name: Company + Interview Prep Brief
  enabled: 'true'
  version: '1.0'
---

# Company + Interview Prep Brief

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this skill to prepare the user for an interview, recruiter conversation, networking call, or late-stage application by combining concise company research with role-specific, resume-grounded interview preparation.

This skill intentionally combines the earlier company research and interview prep workflows because users usually need both together before an interview.

## When to use

Activate when the user asks to:

- research a company before an interview
- prepare for an interview for a specific role
- produce likely interview questions
- identify talking points from their resume
- create a compact company briefing
- find red flags or gaps they may be asked about
- prepare answers using their real experience
- understand company culture, recent news, and interview expectations

## Inputs

Minimum useful inputs:

- company name
- role title or job description
- candidate resume or approved candidate profile

Optional inputs:

- parsed job requirements
- existing alignment analysis
- company website, LinkedIn page, job link, or recruiter message
- interview stage, such as recruiter screen, technical interview, panel, case, or final
- user concerns or topics they want to emphasize/avoid

## Hard rules

1. Separate company research from resume-grounded interview advice.
2. Use public company information cautiously; do not overstate uncertain findings.
3. Use only resume-supported evidence for candidate talking points.
4. Never invent projects, metrics, employers, systems, certifications, or technical depth.
5. Be candid about gaps the interviewer may probe.
6. Generate role-specific questions, not generic interview filler.
7. Keep the report compact enough to review shortly before an interview.

## Research dimensions

Cover only high-signal findings that would change interview prep:

1. **Mission and culture** — how the company describes itself, operating values, team style.
2. **Recent news** — launches, funding, acquisitions, layoffs, earnings, controversies, strategic shifts.
3. **Interview signals** — process patterns, question styles, difficulty, likely expectations.
4. **Employee sentiment** — recurring pros, cons, and review-style themes when available.
5. **Technical/business context** — tools, product areas, business model, operational challenges, domain pressures.

If live research is unavailable or not requested, use only the provided job/company context and label missing research as unknown.

## Interview prep output schema

Recommended output:

```json
{
  "company_brief": {
    "mission_culture": [""],
    "recent_news": [""],
    "interview_signals": [""],
    "employee_sentiment": [""],
    "technical_or_business_context": [""]
  },
  "talking_points": [
    {
      "topic": "skill, responsibility, domain, or business theme",
      "your_strength": "concrete resume evidence to use",
      "gap_to_address": "honest gap or empty",
      "sample_answer_outline": "2-3 sentence answer outline grounded in resume evidence"
    }
  ],
  "likely_questions": [
    {
      "question": "specific likely interview question",
      "category": "technical | behavioral | situational | company | role_fit",
      "suggested_approach": "how to answer using real resume evidence"
    }
  ],
  "red_flags": ["real concerns the interviewer may probe"],
  "key_numbers": ["metrics or numbers exactly present in the resume"],
  "final_prep_plan": ["max 5 concrete actions before the interview"]
}
```

## Method

1. Parse the role's most important requirements.
2. Extract the candidate's strongest matching resume evidence.
3. Research or summarize the company context in compact form.
4. Build talking points around real evidence, not aspirations.
5. Generate likely questions that connect the role requirements to the candidate's evidence and gaps.
6. Surface red flags honestly:
   - missing required tool
   - seniority mismatch
   - weak domain evidence
   - missing certification
   - unclear ownership or metrics
   - logistics mismatch
7. List exact resume numbers worth memorizing. If none exist, return an empty list.

## Length guidance

For a quick prep brief:

- company brief: under 220 words
- talking points: up to 5
- likely questions: up to 6
- final prep actions: up to 5

For deeper prep, expand only when the user explicitly asks.

## Good feedback style

Use direct, practical wording:

- `Lead with the dashboard/reporting evidence because it maps directly to the role's decision-support requirement.`
- `Expect a probe on cloud deployment; the resume does not strongly evidence it, so answer honestly and pivot to adjacent systems work.`
- `Memorize the exact metric from the resume rather than paraphrasing it loosely.`

Avoid:

- generic questions that could apply to any job
- invented technical scenarios
- overstated confidence about company internals

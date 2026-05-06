---
name: grounded-cover-letter-generator
description: >-
  Generate short, specific, non-generic cover letter bodies grounded only in the
  candidate resume, job requirements, and approved user-provided story objectives.
metadata:
  display-name: Grounded Cover Letter Generator
  enabled: 'true'
  version: '1.1'
---

# Grounded Cover Letter Generator

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this skill to draft a credible, role-specific cover letter body without inventing claims. The output should sound useful to the hiring team, not like generic application filler.

## When to use

Activate when the user asks to:

- write or draft a cover letter
- create a cover letter body for a specific job
- make a cover letter less generic
- generate LaTeX-ready cover letter paragraphs
- adapt a cover letter from a resume and job posting
- write a short note explaining fit for an application

## Inputs

Minimum required inputs:

- job description or parsed job requirements
- candidate resume, resume text, LaTeX resume, or approved candidate profile
- a clear cover letter template, sample, or formatting/structure specification from the user

Template requirement:

- Do not generate the final cover letter until the user provides a clear template or confirms a simple structure to use.
- If no template is provided, ask one targeted question requesting the template, sample, or preferred structure.
- A valid template can be a previous cover letter, LaTeX file, plain-text structure, employer-required format, or explicit instruction such as `3 short paragraphs, no address block, professional tone`.

Optional inputs:

- company name
- role title
- user story objectives or emphasis preferences
- tone preference, such as direct, warm, technical, executive, or concise

## Hard rules

1. Ask for a clear template before generating the final cover letter if one is not already provided.
2. Use only resume-supported and user-approved evidence.
3. Never invent skills, tools, employers, projects, certifications, degrees, metrics, dates, or outcomes.
4. Do not copy the job description verbatim.
5. Do not copy the resume bullet-for-bullet; synthesize the strongest evidence.
6. Follow the user's template for structure, pacing, formatting, and tone unless it conflicts with truthfulness.
7. If the template contains placeholders, old personal details, or irrelevant prior content, treat those as formatting/style examples only and replace them with grounded current content.
8. If the company name is missing, use `your team` or `the role` naturally.
9. Avoid clichés such as:
   - `I am excited to apply`
   - `I believe I am a great fit`
   - `I am passionate about`
   - `dynamic team`
   - `perfect fit`
10. Lead with value, not enthusiasm.
11. Keep the letter body concise and specific.

## Recommended output shape

For normal prose:

```text
[Paragraph 1: employer need + strongest matching evidence]

[Paragraph 2: 1-2 concrete achievements or experience threads]

[Paragraph 3: what the candidate would bring and a forward-looking close]
```

For LaTeX workflows, return:

```json
{
  "body_latex": [
    "3-4 short raw LaTeX body paragraphs only, no greeting or signature"
  ],
  "closing": "Best regards,"
}
```

## Method

1. Check whether the user provided a clear cover letter template, sample, or formatting/structure specification.
2. If no clear template exists, pause and ask: `Please provide the cover letter template, sample, or structure you want me to follow.`
3. Parse the employer's core need from the job requirements.
4. Identify 1-3 strongest resume evidence points that directly solve that need.
5. Decide the story arc within the user's template:
   - paragraph 1: role need and candidate fit
   - paragraph 2: concrete evidence with tools, outcomes, stakeholders, or scope
   - optional paragraph 3: additional relevant evidence or context
   - final paragraph: value and next step
6. Use user story objectives only to shape emphasis. They must not introduce unsupported claims.
7. Keep the combined body between 170 and 250 words unless the template or user asks otherwise.
8. If evidence is thin, be specific but restrained rather than padding.

## Grounding checklist

Before finalizing:

- Does every tool, skill, domain, employer, metric, and outcome appear in the resume or approved source?
- Does the letter name the employer's likely need rather than generic enthusiasm?
- Is the strongest evidence selected, not merely the most recent evidence?
- Is the tone confident without exaggeration?
- Is the content short enough to be read quickly?
- If LaTeX output is requested, does it avoid document wrappers like `\\documentclass` or `\\begin{document}`?

## Good style

Prefer:

- `Your role calls for someone who can translate messy operational data into clear decision support. My resume shows that pattern through...`
- `I would bring practical experience in X, evidenced by Y, and the ability to communicate Z to stakeholders.`

Avoid:

- `I am excited to apply for this amazing opportunity.`
- `My diverse background makes me the ideal candidate.`
- `I can contribute to your dynamic team with my passion and dedication.`

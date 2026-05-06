---
name: linkedin-profile-optimizer
description: >-
  Audit and improve a user's LinkedIn profile for target roles by reviewing
  headline, About, Experience, Projects, Featured, Skills, keywords, proof
  density, recruiter search alignment, and profile completeness. Draft changes
  safely and stop before saving profile edits unless explicitly confirmed.
metadata:
  display-name: LinkedIn Profile Optimizer
  enabled: "true"
  version: "1.0"
---

# LinkedIn Profile Optimizer

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this to make a LinkedIn profile stronger for target roles without inventing facts or saving edits prematurely.

Default posture: **audit, draft, stage if requested, and stop before save.**

## Inputs

- target role family or search goal
- current profile page
- resume/CV or approved source material
- target geography or industry when relevant

## Audit Areas

Review:

- headline clarity and keywords
- About section specificity and proof
- Experience bullets and impact evidence
- Projects and Featured section
- Skills alignment with target roles
- education, certifications, awards, and languages
- profile URL, creator mode, contact info visibility, and recruiter-facing completeness when visible

## Rewrite Rules

- Use only approved resume/profile evidence.
- Preserve truthful scope, dates, roles, employers, degrees, and metrics.
- Prefer specific role-family keywords over generic buzzwords.
- Keep language natural and recruiter-readable.
- Do not add tools, certifications, publications, awards, or outcomes unless source-backed.

## Browser Procedure

1. Open the profile.
2. Capture current visible sections.
3. Identify gaps and high-impact edits.
4. Draft replacement text outside the edit form first.
5. If asked to stage edits, open the relevant edit dialog and fill carefully.
6. Stop before clicking `Save` unless the user explicitly approves that exact section.

## Output Standard

Return:

```text
Profile goal:
Top issues:
Recommended edits:
Draft headline:
Draft About:
Section-specific changes:
Unsupported claims avoided:
Save status:
```


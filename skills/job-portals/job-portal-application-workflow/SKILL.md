---
name: job-portal-application-workflow
description: >-
  Prepare job applications on any external job portal or company career site,
  including Saudi and Gulf portals, company ATS pages, Workday, Lever,
  Greenhouse, Ashby, Bayt, Naukrigulf, and unfamiliar forms. Learn unknown
  portals safely, use approved answer-bank data only, attach verified documents,
  and stop before final submission unless explicitly confirmed.
metadata:
  display-name: Job Portal Application Workflow
  enabled: "true"
  version: "1.1"
---

# Job Portal Application Workflow

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this for non-LinkedIn job applications and LinkedIn external redirects. It is designed for unknown portals and Saudi/Gulf career pages as well as common ATS platforms.

Default mode: **prepare, verify, and stop before final submit.**

## Companion Skills

- Use `browseros-skill-router` at the start of complex requests.
- Use `browseros-new-site-learning-protocol` for unfamiliar portals.
- Use `application-answer-bank-protocol` for personal answers and file choices.
- Use `resume-hallucination-risk-audit` when new application text is created.
- Use `obsidian-job-search-keyword-intelligence` when tracking applications or avoiding duplicates matters.

## Preflight

Before filling:

- Confirm role, company, portal URL, and target location.
- Check duplicate status if this is part of job search or outreach.
- Identify the intended CV, cover letter, transcript, portfolio, or other files.
- Verify local files exist before upload.
- Determine whether an account/login is required.
- If a portal is unknown, map it before entering sensitive data.

## Fast Path

For known ATS pages:

```text
get_page_links on board -> open exact job URL -> snapshot form -> DOM search for file inputs/required fields -> stop at final submit
```

For unknown portals, run a first-time map before entering personal data. Use
page links/content before clicking listing cards one by one.

## Portal Handling

Known families:

- Workday: expect account/login, multi-step profile forms, saved drafts, and repeated field sections.
- Lever, Greenhouse, Ashby: expect cleaner single or multi-page forms, resume upload, text questions, and optional demographic sections.
- Bayt, Naukrigulf, and Gulf portals: expect profile-first flows, account state, saved CVs, and regional fields.
- Company career pages: expect custom forms or ATS redirects.

If the portal does not match a known family, run the new-site learning protocol.

For detailed Greenhouse behavior observed in live BrowserOS runs, load
`references/greenhouse-ats.md`.

## Filling Rules

- Fill only fields supported by the approved private answer bank or explicit user input.
- Optional demographic, disability, veteran, nationality, or equal-opportunity questions should be skipped or set to a user-approved preference only.
- Do not answer salary, sponsorship, authorization, relocation, notice period, availability, years of experience, language, degree, or certification fields unless approved.
- Preserve the portal's required format: number, dropdown, date, yes/no, or free text.
- Do not treat an enabled final submit button as readiness. Some portals leave
  submit enabled and validate required fields only after click.
- Read validation errors before retrying.

## Upload Rules

- Upload only the exact intended file.
- Verify the visible uploaded filename.
- If the portal hides the filename or shows a generic card, stop unless another reliable signal confirms the file.
- Do not reuse an old saved CV unless the exact filename/content is verified.

## Final Review

Before final submission, report:

```text
Role:
Company:
Portal URL:
Documents attached:
Required fields completed:
Unknown or skipped fields:
Final button text:
Ready state:
```

Never click the final submit/apply button without explicit confirmation for that exact application.

## After Submission

If explicitly authorized and submitted:

- verify confirmation text, email, application ID, or dashboard state
- save the application URL and status
- update the user's tracking system if requested
- record any portal-specific learning for future skill improvement

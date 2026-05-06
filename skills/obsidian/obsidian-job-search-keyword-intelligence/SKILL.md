---
name: obsidian-job-search-keyword-intelligence
description: >-
  Maintain a local Obsidian job-search keyword intelligence vault: update
  keyword maturity, search logs, duplicate exclusions, outreach lead notes,
  email status dashboards, Dataview/Mermaid graph views, source/recruiter nodes,
  and application-path records after hiring-post search or outreach batches.
metadata:
  display-name: Obsidian Job Search Keyword Intelligence
  enabled: "true"
  version: "1.0"
---

# Obsidian Job Search Keyword Intelligence

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Trigger

Use this skill whenever the user asks to:

- improve or use a job-search keyword vault
- search for LinkedIn, regional, or role-specific hiring posts
- track sent/not-sent outreach emails
- avoid duplicate jobs already contacted
- save useful, noisy, testing, or proven keywords
- build graph-friendly Obsidian notes for recruiters, companies, role families, leads, sources, or search passes

## Vault location

Use the user-provided Obsidian vault path. Do not hardcode local machine paths.

Recommended structure:

```text
<obsidian-vault-root>/Job Search Keywords/
```

If the vault path is unknown, ask for it or infer it only from explicit user-provided context.

## Core principle

Every serious search creates feedback.

For each search pass:

1. Check duplicate exclusions first.
2. Search and score leads.
3. Save each useful search in `06 Search Log.md`.
4. Add new terms to `Keywords/Testing Keywords.md`.
5. Promote only repeatedly successful terms to `Keywords/Proven Keywords.md`.
6. Add irrelevant or low-quality patterns to `Keywords/Noisy Keywords.md`.
7. Create/update a batch note in `Outreach/Batches/`.
8. Create one graph-friendly lead note per accepted lead in `Outreach/Leads/`.
9. Link each lead to company/source, recruiter/poster, role family, status, and keywords.
10. Update `08 Outreach & Email Tracking.md` if statuses change.

## Duplicate prevention

Before accepting a lead, read:

- `Outreach/Prior Outreach Exclusion List.md` or the closest local exclusion note
- recent batch notes in `Outreach/Batches/`
- recent lead notes in `Outreach/Leads/`
- workspace run ledgers if available

Reject a candidate if it overlaps by any of:

- same email
- same company plus same role
- same poster/source plus same role phrase
- same LinkedIn post/contact route
- same Gmail/Outlook draft already created

If uncertain, mark as `duplicate_risk_review` rather than accepting silently.

## Lead-note YAML schema

Use this frontmatter for each accepted lead:

```yaml
type: outreach_lead
batch: "[[YYYY-MM-DD Batch Name]]"
date_found: YYYY-MM-DD
channel: SearchOnly | Gmail | Outlook | LinkedIn
email_status: not_drafted | drafted_not_sent | sent | follow_up_due | replied | closed | duplicate_rejected
sent: false
recipient: "email@example.com"
gmail_message_id:
outlook_message_id:
score: 0
fit_rank: 0
role: "Role Title"
company: "Company or source"
poster: "Recruiter/poster/source"
location: "City / Region"
source_type: "LinkedIn post / company page / Google X-ray fallback / job board"
duplicate_check: "passed_against_exclusion_pool"
keywords: []
application_path:
tags:
  - outreach
  - job-lead
```

## Email status meanings

- `not_drafted`: lead found but no email draft created yet.
- `drafted_not_sent`: draft exists, not sent.
- `sent`: email was sent. Add `sent_date` and follow-up due date.
- `follow_up_due`: sent email needs follow-up.
- `replied`: recipient replied.
- `closed`: rejected, expired, irrelevant, or abandoned.
- `duplicate_rejected`: rejected because it overlaps prior outreach.

## Search scoring

Use the lead-scoring model:

- Recency: 24h = 2, week = 1, older/unclear = 0
- Role match: explicit = 2, adjacent = 1
- Geography: clear target region = 2, broad regional hint = 1
- Contact clarity: visible public email = 3, clear apply CTA = 2, vague CTA = 1
- Poster credibility: recruiter/company/hiring manager = 1

If the user has a current preference such as email-first leads, direct application routes, remote-only roles, or a target country, encode that as a configurable filter in the batch note rather than hardcoding it into the skill.

## Keyword maturity

- New: seen once, not tested enough
- Testing: produced at least one usable lead but not repeatedly proven
- Proven: repeatedly produces relevant, actionable leads across sessions
- Noisy: repeatedly produces irrelevant, old, wrong-region, or wrong-seniority results
- Retired: stop using unless explicitly revived

## Required outputs after a search pass

1. Batch note in `Outreach/Batches/`.
2. Lead notes in `Outreach/Leads/` for accepted leads.
3. Search-log entry in `06 Search Log.md`.
4. Keyword maturity updates.
5. Source nodes in `Sources/Companies.md` and `Sources/Recruiters.md` when applicable.
6. A workspace ledger JSON/MD for automation reuse.
7. If a job has a company/careers/application-site path, add it to `Application Paths/` and link it from the lead.
8. Rank accepted postings by candidate fit, not just raw hiring signal, so the user can manually review the best opportunities first.

## Company/application-site path tracking

When a post has an apply link, company careers page, job board URL, or LinkedIn job path:

- Create or update `Application Paths/Application Paths Dashboard.md`.
- Create one note per useful path in `Application Paths/` when details are available.
- Link the path from the lead note using `application_path:` YAML and a visible Markdown link.
- Track whether the route is `email`, `company_site`, `linkedin_job`, `recruiter_link`, `form`, or `unknown`.
- Do not treat link-only routes as email outreach. They are manual-review/application paths.
- If both visible email and apply link exist, save both.

## Candidate-fit ranking

Rank leads by fit using a user-approved candidate profile or resume summary.

Default fit factors:

- direct role-family match
- early-career or seniority fit if relevant
- target geography or remote preference
- overlap with verified tools, domains, languages, or methods
- visible public email or direct application route
- penalties for senior-only roles, niche stack mismatch, wrong location, or old/unclear recency

Store both `score` and `fit_rank` in the lead note.

## Style rules for outreach systems

- Use the user's requested language for email bodies.
- Keep tone natural and human; avoid stiff or robotic phrasing.
- Do not mention protected personal attributes unless the user explicitly asks and it is appropriate.
- Do not say "tailored resume" or "tailored CV" unless the user wants that wording.
- Do not claim an attachment unless it is actually attached or staged.
- Do not send messages/emails without explicit confirmation.
- Treat lead emails, names, profile URLs, message bodies, vault paths, and filenames as sensitive in chat summaries.

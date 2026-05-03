---
name: linkedin-row-enrichment
description: Improve selected Outreach sheet rows by opening only the necessary LinkedIn thread or profile to fill missing profile URL, title, company, and clearer next-step context.
metadata:
  display-name: LinkedIn Row Enrichment
  enabled: "true"
  version: "1.1"
---

# LinkedIn Row Enrichment

## Purpose
Upgrade the most important rows from minimally useful to action-ready.

This skill assumes rows already exist in the simple `Outreach` sheet and some fields are still blank or lightly noted.

## One-sheet rule
Enrichment improves the existing row.
It does not create a separate enrichment sheet, QA sheet, or research sheet.

## Use this when
- the user wants the sheet improved further
- high-priority rows need `profile_url`, `title`, or `company`
- follow-up decisions need better context
- a name match needs verification

## What this mode should improve
Typical target fields:
- `profile_url`
- `title`
- `company`
- `stage` if preview-only inference was weak
- `next_action`
- `next_action_on`
- `notes`

## Row selection strategy
Do not enrich rows randomly.

Prioritize in this order:
1. rows with upcoming or overdue `next_action_on`
2. rows with `next_action = Reply` or `Follow up`
3. rows missing `profile_url`
4. rows missing `title` or `company`
5. rows marked `needs_review`

## Open-target discipline
Open a thread only when you need conversation state.
Open a profile only when you need profile identity or role/company details.

## Recommended workflow
For one row at a time:
1. identify the target row in the sheet
2. find the matching LinkedIn conversation or profile
3. open the thread if reply state or context matters
4. open the profile if URL, title, or company are needed
5. update only the missing or corrected fields
6. keep notes short

## Notes conventions
Good short notes include:
- `preview_only`
- `needs_review`
- `profile_confirmed`
- `ready_for_followup`
- `reply_received`

Avoid verbose notes and full message transcripts.

## Anti-waste rules
- do not enrich low-value rows first
- do not open a profile just to confirm obvious data
- do not add new columns for enrichment tracking
- do not split enrichment across new sheets
- patch missing fields only
- stop when additional opens are no longer improving actionability

## Best outcome
A smaller number of rows become clearly actionable and trustworthy, which is better than shallow enrichment across everything.

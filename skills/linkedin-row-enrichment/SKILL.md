---
name: linkedin-row-enrichment
description: Enrich already-imported LinkedIn outreach rows by opening only selected threads or profiles to fill profile URL, title, company, exact message context, and higher-confidence values.
metadata:
  display-name: LinkedIn Row Enrichment
  enabled: "true"
  version: "1.0"
---

# LinkedIn Row Enrichment

## Purpose
Upgrade preview-imported rows into high-confidence rows.

This skill assumes rows already exist in `Outreach_Table` and some fields still contain placeholders like:
- `pending_enrichment`
- `TBD`
- `preview_only`
- `last_outbound_needs_backfill`

## Use this when
- the user says “improve the sheet further”
- high-priority rows need title/company/profile links
- follow-up drafts need better context
- you need exact thread or profile details

## What this mode should improve
Typical target fields:
- LinkedIn URL
- Title
- Company
- exact last outbound message
- exact last inbound message
- more accurate status
- exact follow-up reason
- higher data confidence
- better review notes

## Row selection strategy
Do **not** enrich rows randomly.

Prioritize in this order:
1. `Priority = high`
2. `Status = waiting_on_reply`
3. `Enrichment Status = preview_only`
4. rows with strong draft/follow-up potential
5. rows with ambiguous review notes

Suggested first enrichment targets:
- founders
- recruiters
- hiring managers
- strong-fit people at target companies
- rows where one profile open would unlock multiple fields

## Open-target discipline
Only open a thread or profile when it will answer a real question.

Open a **thread** when you need:
- exact outbound/inbound messages
- precise reply state
- actual last touch context
- thread-specific details not available in preview

Open a **profile** when you need:
- LinkedIn URL
- headline/title
- company
- role context

## Recommended enrichment workflow
For one row at a time:
1. identify the target row from the sheet
2. find the matching conversation in LinkedIn
3. open the thread if message context is needed
4. open the profile if role/company/URL are needed
5. update only the missing fields
6. raise confidence if the values were confirmed
7. update `Last Verified At`
8. revise `Review Notes`

## Confidence upgrade rules
Raise to `high` only when the data was directly confirmed from thread/profile view.

Examples:
- preview only → `medium`
- profile opened and company/title confirmed → `high`
- exact message text confirmed in-thread → `high`

Keep at `medium` when:
- the row still depends on preview inference
- URL or company remains unconfirmed

## Recommended field updates

### After profile open
Update:
- LinkedIn URL
- Title
- Company
- Enrichment Status
- Data Confidence
- Last Verified At
- Review Notes

### After thread open
Update:
- Last Outbound Message
- Last Inbound Message
- Status
- Awaiting Reply From
- Last Touch Direction
- Followup Reason
- Backfill Status
- Data Confidence
- Last Verified At

## Review Notes conventions
Good values include:
- `title_company_url_confirmed`
- `thread_verified`
- `last_outbound_confirmed`
- `last_inbound_confirmed`
- `still_missing_profile_url`
- `profile_not_accessible`
- `thread_state_ambiguous`

## Enrichment Status conventions
Suggested values:
- `preview_only`
- `partially_enriched`
- `fully_enriched`
- `needs_manual_review`

## Anti-waste rules
- do not open low-priority rows first
- do not enrich rows whose data will not affect actionability
- do not open a profile just to confirm something obvious from an already high-confidence row
- patch missing fields only
- stop after 3–5 good enrichments if quality begins dropping

## Best outcome of this mode
A small number of rows become genuinely strong:
- complete profile information
- exact context
- trustworthy follow-up reasoning
- better drafts

This is more valuable than shallow enrichment of 50 rows.

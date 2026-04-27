---
name: linkedin-inbox-preview-backfill
description: Backfill recent LinkedIn outreach into Google Sheets using inbox preview data first, with bounded passes, confidence labeling, and minimal thread opens.
metadata:
  display-name: LinkedIn Inbox Preview Backfill
  enabled: "true"
  version: "1.0"
---

# LinkedIn Inbox Preview Backfill

## Purpose
Populate a Google Sheet from recent LinkedIn outreach as fast as possible **without** opening every thread.

This is the best starting mode when:
- the sheet is empty or mostly empty
- the user wants historical outreach imported quickly
- accuracy can begin at preview-level and improve later
- speed matters more than immediate perfect enrichment

## Core rule
**The inbox preview is the first pass, not a shortcut to ignore.**

The preview pass is usually the highest-leverage step because it lets you:
- identify active threads
- capture names
- capture last-touch direction
- infer reply state
- identify follow-up candidates
- avoid opening unchanged or low-value threads

## What this mode should produce
A row should be considered successful in preview-backfill mode if it contains:
- Name
- Date Contacted / last visible activity marker
- Status
- Last Outbound Message or Last Inbound Message
- Awaiting Reply From
- Source
- Enrichment Status
- Next Action
- Priority
- Backfill Status
- Person Key
- Thread Key
- Capture Method
- Data Confidence
- Import Run ID
- Imported At
- Last Verified At
- Followup Reason
- Review Notes

It is acceptable for these fields to remain placeholders during this pass:
- LinkedIn URL
- Title
- Company
- exact follow-up date
- exact canonical timestamp

## When to use
Use this skill when the user says things like:
- fill the sheet from my LinkedIn messages
- backfill recent outreach
- import the people I messaged
- start with the latest conversations
- just get the table populated first

## Preparation
Before touching LinkedIn:
1. Ensure the spreadsheet exists
2. Ensure `Outreach_Table` exists
3. Ensure traceability columns exist
4. Ensure `Import_Log` exists
5. Create an `import_run_id`

Suggested import run ID format:
`li_preview_backfill_YYYY-MM-DD_HHMMSS`

## Bounded import rules
Recommended defaults:
- backfill only the most recent **50** threads on first run
- capture only the latest visible message signal from preview
- do one bounded load-more pass at most unless the user explicitly wants deeper history
- retry one interaction per inbox action at most

## Data capture from inbox preview
From each visible conversation tile, collect if visible:
- name
- relative activity date/time
- preview line
- whether preview begins with `You:` or the other person name
- unread badge if visible
- any strong signal like deleted message / attachment / post share

## How to interpret preview rows

### If preview begins with `You:`
Assume:
- `Last Touch Direction = outbound`
- likely `Status = waiting_on_reply`
- `Awaiting Reply From = them`
- `Followup Reason = awaiting_reply_after_outbound`

### If preview begins with the other person name
Assume:
- `Last Touch Direction = inbound`
- likely `Status = replied` or `active_conversation`
- `Awaiting Reply From = me`
- `Followup Reason = reply_received`

### If preview is ambiguous
Use:
- `Status = needs_review`
- `Awaiting Reply From = none`
- `Review Notes = ambiguous_preview`

## Suggested row-writing strategy
For each row:
1. write the minimum useful fields first
2. write metadata second
3. write placeholders for enrichment gaps
4. log the run once per batch, not once per row

Placeholders should be explicit, for example:
- `pending_enrichment`
- `TBD`
- `preview_only`
- `last_outbound_needs_backfill`

## Priority heuristics
Suggested values:
- `high` = strong outreach, recruiter/founder/target company, clear follow-up candidate
- `medium` = useful contact awaiting response
- `low` = casual exchange, weak signal, low leverage thread

## Next Action values
Good defaults:
- `enrich_profile_then_followup`
- `backfill_last_outbound_then_decide`
- `review_manually`
- `none`

## Trackability requirements
Every preview-imported row should include:
- `Capture Method = linkedin_inbox_preview`
- `Data Confidence = medium`
- `Import Run ID = current batch id`
- `Imported At = run timestamp`
- `Last Verified At = run timestamp`
- `Review Notes = what remains missing`

## Anti-retry rules
- never reopen the same successful row in the same run
- never rerun a whole batch if only 1–2 cells failed
- verify and patch missing cells only
- if load more does not yield reliable new rows, stop
- do not brute-force the inbox UI

## Stop conditions
Stop the preview pass when:
- the visible rows become noisy or low-quality
- load-more stops returning clearly usable conversations
- connector instability rises and patching becomes cheaper than continued expansion
- the user has enough recent outreach imported to start operating

## Output quality target
At the end of this mode, the sheet should be:
- operational
- sortable
- auditable
- not yet fully enriched

That is the correct outcome.

## What happens next
After preview backfill, switch to:
- `linkedin-row-enrichment` for quality upgrades
- `linkedin-outreach-daily-ops` for ongoing monitoring

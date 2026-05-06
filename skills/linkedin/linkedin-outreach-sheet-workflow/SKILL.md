---
name: linkedin-outreach-sheet-workflow
description: Run LinkedIn outreach from one simple Google Sheet named Outreach using a single working tab, a small stable schema, iterative row improvement, and Google Sheets connector-first updates. Use when the user wants to add leads, backfill messages, enrich rows, process replies, or manage follow-ups without multi-sheet CRM complexity.
metadata:
  display-name: LinkedIn Outreach Sheet Workflow
  enabled: "true"
  version: "1.2"
---

# LinkedIn Outreach Sheet Workflow

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose
Keep LinkedIn outreach tracking simple enough that it stays usable.

This skill is the source of truth for how LinkedIn workflows should be documented in Google Sheets.

## Default model
Use one spreadsheet and one working sheet tab:
- spreadsheet: `Outreach`
- sheet tab: `Outreach`

One row equals one person. Improve that row over time instead of spreading state across tabs.

Do not create extra tabs by default:
- no import tabs
- no log tabs
- no enrichment tabs
- no follow-up tabs
- no dashboard tabs
- no staging tabs
- no archive/helper tabs

Use a multi-tab workbook only when the user explicitly asks for a CRM-style system or the workflow has outgrown one sheet in a concrete way.

## Core schema
Default columns:
- `added_on`
- `full_name`
- `profile_url`
- `title`
- `company`
- `stage`
- `last_contact_on`
- `last_contact_direction`
- `next_action_on`
- `next_action`
- `notes`

Optional columns, only when clearly useful:
- `source`
- `thread_url`

Do not add more columns unless the user asks or the same need repeats enough to justify it.

## Keys and matching
Match rows in this order:
1. normalized `profile_url`
2. `thread_url`
3. careful name match

Never create a second row for the same person when an existing row can be updated safely.

## Stage values
Use only these durable relationship states:
- `Lead`
- `Invited`
- `Connected`
- `Messaged`
- `Replied`
- `Nurture`
- `Closed`

Do not create pseudo-stages like `followup_due`, `waiting_on_reply`, or `needs_enrichment`.

Keep work state in:
- `next_action_on`
- `next_action`

Example:
- `stage = Messaged`
- `next_action_on = 2026-05-10`
- `next_action = Follow up`

## Field meanings
- `stage` = relationship state
- `last_contact_on` = latest known touch date or visible activity marker
- `last_contact_direction` = `outbound`, `inbound`, or blank when unknown
- `next_action_on` = next date worth revisiting
- `next_action` = short instruction such as `Follow up`, `Reply`, `Review`, or blank
- `notes` = short durable context, not transcripts and not a mini CRM log

## Iterative workflow

### Pass 1: capture
Create a minimal useful row quickly.

Usually enough:
- `added_on`
- `full_name`
- `stage`
- `last_contact_on`
- `last_contact_direction`
- `next_action`
- `notes`

### Pass 2: enrich
Only improve selected rows that matter.

Typical additions:
- `profile_url`
- `title`
- `company`
- stronger `next_action`
- better `next_action_on`

### Pass 3: maintain
Update only what changed.

Do not rewrite the whole sheet. Patch the active rows and keep moving.

## Operating rules
1. Never create a second row for the same person.
2. Normalize LinkedIn profile URLs before matching or writing.
3. If a row already exists, update only changed fields.
4. Do not overwrite confirmed data with weaker guesses.
5. Keep `notes` short, durable, and action-relevant.
6. Prefer blanks over placeholder clutter unless a short note prevents confusion.
7. Keep the queue honest: if something is done or irrelevant, clear or update `next_action` intentionally.
8. Use the Google Sheets connector first.
9. If browser fallback is needed, keep only one relevant Google Sheets tab open and edit a small scope.

## Reporting privacy
The sheet may contain names, profile URLs, titles, companies, thread URLs, and private message context. In chat summaries, prefer row numbers, initials, or redacted labels unless the user asks for full identifiers. Do not paste message transcripts; use short action-focused labels instead.

## Connector-first update flow
1. Read current headers and candidate rows.
2. Prepare only rows that need to be added or updated.
3. Write in small logical batches.
4. Re-read the changed rows.
5. Patch only missing or failed cells.
6. Use browser editing only if the connector is blocking urgent work.
7. Even in browser fallback, keep the same one-sheet model.

## What this skill should handle
- add new leads
- record connection requests
- record messages sent
- process replies
- backfill recent outreach
- enrich incomplete rows
- review due follow-ups
- reconcile duplicates
- iteratively improve tracking quality without adding sheet complexity

## What not to build by default
- no multi-sheet workbook architecture
- no `Import_Log`
- no `Outreach_Table`
- no one-row-per-message system
- no workflow documentation sheet
- no giant audit framework
- no duplicate rows for the same person
- no secondary status taxonomy beyond the stage list above

## Optional advanced mode
If the user explicitly asks for a full CRM-style workbook, use normalized tabs such as `People`, `Threads`, `Activity_Log`, `Queue`, and `Import_Log`.

Do not switch to this mode just because the connector is flaky. Connector friction should be handled with smaller verified writes, not more tabs.

## Success criteria
The system is successful when:
- the sheet is readable months later
- each person appears once
- the next step is obvious
- new activity is updated quickly
- the workflow is documented through row quality, not extra tabs
- the user does not need to open many sheets to understand what is going on

## Output expectations
When setting up or revising the sheet, report:
- final columns
- allowed stage values
- simplifications made
- rows that still need manual review

Optimize for one-sheet clarity, speed, and maintainability.

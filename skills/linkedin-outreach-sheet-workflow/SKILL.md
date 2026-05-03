---
name: linkedin-outreach-sheet-workflow
description: Build and operate a high-traceability LinkedIn outreach tracking system using LinkedIn browser automation plus the Google Sheets connector. Use when the user wants to backfill LinkedIn messages, monitor outreach, manage follow-ups, or design a scalable outreach sheet from scratch.
metadata:
  display-name: LinkedIn Outreach Sheet Workflow
  enabled: "true"
  version: "1.0"
---

# LinkedIn Outreach Sheet Workflow

## Purpose
Build a durable, efficient, auditable workflow for tracking LinkedIn outreach in Google Sheets.

This skill assumes:
- LinkedIn inbox/messages must be handled in the browser
- Google Sheets is the structured storage and operating system
- The user wants speed, minimal waste, and strong traceability

## Core Reality
**Do not treat LinkedIn + Google Sheets as a single connector workflow.**

Use a **hybrid architecture**:
- **LinkedIn browser automation** for inbox, threads, connection activity, replies, and message content
- **Google Sheets connector** for structured rows, queueing, metadata, and reporting

Why:
- LinkedIn connector support may not expose inbox/connections actions
- Google Sheets connector is reliable for structured writes, but often cell-oriented and worth using carefully
- Browser observation is best for deciding what changed; Sheets is best for storing durable state

## Design Principles
1. **Scan cheaply first** — inspect the LinkedIn conversation list before opening threads
2. **Open only changed or high-value threads**
3. **Append history, update state** — never overwrite history logs
4. **Use stable keys everywhere**
5. **Track capture confidence and source**
6. **Retry at most once per thread**
7. **Never rescan the same successful thread in the same run**
8. **Prefer bounded passes over heroic full-history imports**

## Recommended Workbook Structure

### Minimum viable tabs
If the user wants a lightweight setup:
- `Outreach_Table`
- `Import_Log`
- `Meta`

### Single-sheet mode
If the user explicitly wants the simplest durable tracker, use one Google Sheet named `Outreach` instead of the normalized workbook.

Use this model:
- one row = one person
- unique key = normalized LinkedIn profile URL
- lifecycle state = `stage`
- queue state = `next_action_on` plus `next_action`
- filters/views instead of helper tabs

Required columns:
- `added_on`
- `full_name`
- `profile_url`
- `title`
- `company`
- `stage`
- `last_outbound_on`
- `last_inbound_on`
- `next_action_on`
- `next_action`
- `notes`

Durable stage values:
- `Lead`
- `Invited`
- `Connected`
- `Messaged`
- `Replied`
- `Nurture`
- `Closed`

Do not add duplicate rows for the same `profile_url`. If a row exists, patch only changed fields and avoid overwriting verified data with weak guesses. Keep notes short; do not paste full message transcripts into the sheet.

### Recommended full setup
For a serious system, create:
- `People`
- `Threads`
- `Activity_Log`
- `Queue`
- `Lookups`
- `Meta`
- `Dashboard`
- `IDX_People`
- `IDX_Threads`
- `Workflow`
- `Outreach_Table`
- `Import_Log`

## Best Role of Each Tab

### `Outreach_Table`
Operator-facing table. Best for triage, follow-up, and quick review.

Recommended columns:
- Name
- Title
- Company
- LinkedIn URL
- Date Contacted
- Status
- Follow Up Date
- Last Outbound Message
- Last Inbound Message
- Message Draft
- Awaiting Reply From
- Source
- Enrichment Status
- Next Action
- Priority
- Backfill Status
- Person Key
- Thread Key
- Last Touch Direction
- Capture Method
- Data Confidence
- Import Run ID
- Imported At
- Last Verified At
- Followup Reason
- Review Notes

### `People`
One row per person. Master relationship state.

Use for:
- profile identity
- role/company
- relationship stage
- value/priority scoring
- reply ownership
- last touch timestamps

### `Threads`
One row per LinkedIn conversation thread.

Use for:
- thread URL / thread key
- last message preview
- unread status
- last synced time
- fingerprint of latest content
- next best action

### `Activity_Log`
Append-only event history.

Use for:
- every inbound message
- every outbound message
- connection accepted
- follow-up scheduled
- status changes

### `Queue`
One row per pending action.

Use for:
- reply
- follow_up
- welcome
- review_manually
- archive

### `Import_Log`
Audit trail for ingestion runs.

Recommended columns:
- Import Run ID
- Imported At
- Source
- Mode
- Rows Added
- Rows Updated
- Confidence
- Notes

### `IDX_People` and `IDX_Threads`
Fast lookup tables that map keys to row numbers.

Why they matter:
- avoid scanning the entire sheet to find a row
- make updates deterministic
- reduce duplicate creation

### `Meta`
System controls.

Recommended keys:
- schema_version
- people_next_row
- threads_next_row
- activity_log_next_row
- queue_next_row
- initial_backfill_thread_limit
- delta_mode
- max_retries_per_thread
- capture_latest_message_count
- skip_if_unchanged
- same_run_rescan
- queue_manual_review_on_failure
- max_threads_per_run
- last_full_backfill_at
- last_delta_sync_at

## Stable Key Strategy
Never rely on names alone.

Use:
- `person_key` = normalized LinkedIn URL if available, otherwise slugged name placeholder
- `thread_key` = thread URL or stable thread identifier
- `event_key` = thread_key + timestamp + direction + short fingerprint
- `action_key` = person_key + action_type + due_date
- `import_run_id` = one ID for the entire batch, e.g. `li_preview_backfill_YYYY-MM-DD_HHMMSS`

## Capture Methods
Use one of these values in `Capture Method`:
- `linkedin_inbox_preview`
- `linkedin_thread_open`
- `linkedin_profile_open`
- `manual_user_input`

## Data Confidence Rules
Use confidence labels explicitly.

Recommended:
- `high` = thread opened, profile verified, exact values confirmed
- `medium` = taken from inbox preview, likely correct but not fully enriched
- `low` = inferred, partial, or manually guessed from weak signals

## From-Scratch Build Workflow

### Phase 1 — Create the workbook
1. Create/open the spreadsheet
2. Create all required tabs
3. Write header rows first
4. Seed `Meta`, `Lookups`, and `Import_Log`
5. Decide whether the user wants MVP or full normalized system

### Phase 2 — Define operating rules
Add these rules immediately:
- initial backfill limited to 50 recent threads
- capture only latest 3 messages per thread unless user requests deeper backfill
- skip unchanged threads
- retry once max
- queue manual review on failure

### Phase 3 — First backfill
1. Open LinkedIn messaging in a background tab
2. Read the conversation list first
3. Capture visible rows from preview
4. Write the operator table fast
5. Mark rows as `preview_only`
6. Enrich only the highest-priority rows afterward

This gives a useful system quickly without trying to solve the whole inbox at once.

## Efficient LinkedIn Reading Workflow

### Inbox preview pass
Always begin with the conversation list.

From each visible thread tile, capture if available:
- name
- relative date / last activity
- preview text
- whether the preview is `You:` or their name
- unread indicator
- presence / active status if useful

Then classify:
- `Last Touch Direction` = inbound or outbound
- `Status` = waiting_on_reply / replied / active_conversation / unclear
- `Awaiting Reply From` = them / me / none
- `Next Action` = enrich_profile_then_followup / backfill_last_outbound_then_decide / review_manually

### Thread-open pass
Open a thread only when:
- it is new
- it is unread
- preview changed
- profile/title/company need enrichment and the row is high priority
- last outbound or inbound needs precise backfill
- preview signals are ambiguous

Avoid opening threads when:
- nothing changed
- you already captured the thread successfully in the same run
- the row is low-value and preview already provides enough information

## Anti-Retry Discipline
This is critical.

### Never do this
- repeatedly click the same thread because data “might” be there
- rerun an entire 20-cell write batch because 2 cells failed
- reopen a thread in the same run after a successful capture
- scan the full inbox after every small write

### Do this instead
- retry once per thread at most
- verify partial writes and patch only missing cells
- test a single connector write after a service error
- reduce batch size after any 503/timeout
- mark unresolved items in `Review Notes`
- keep moving forward

## Recommended Write Order
When a thread is processed:
1. Append new message/event rows to `Activity_Log`
2. Upsert `People`
3. Upsert `Threads`
4. Upsert `Outreach_Table`
5. Create/update `Queue`
6. Update indexes
7. Write one `Import_Log` row for the run
8. Update `Meta.last_delta_sync_at`

Why this order works:
- history is preserved first
- current state reflects history
- action queue reflects current state

## How to Populate `Outreach_Table` Efficiently

### For initial backfill
Populate these first, even if enrichment is incomplete:
- Name
- Date Contacted
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

If `Title`, `Company`, or `LinkedIn URL` are missing, write:
- `pending_enrichment`

This is acceptable and better than blocking ingestion.

### For later enrichment
Open the best rows and replace:
- Title
- Company
- LinkedIn URL
- exact follow-up date
- exact last outbound/inbound if needed

## Priority Rules
Simple operator-friendly values work well:
- `high`
- `medium`
- `low`

Suggested initial heuristics:
- `high` = strong recruiting/outreach message, strategic target, clear follow-up candidate
- `medium` = useful contact, awaiting reply, moderate relevance
- `low` = casual exchange, resolved thread, weak target, or low strategic value

## Status Rules
Recommended values:
- `waiting_on_reply`
- `replied`
- `active_conversation`
- `needs_review`
- `archived`

## Follow-Up Rules
Recommended values in `Followup Reason`:
- `awaiting_reply_after_outbound`
- `reply_received`
- `followup_due`
- `profile_enrichment_needed`
- `last_outbound_needs_backfill`
- `unclear_thread_state`

## Connector Usage Rules
Because Google Sheets writes may be granular:
- keep writes small and grouped logically
- if a batch partly fails, verify and patch only gaps
- avoid blank writes when the connector dislikes empty values
- use explicit placeholders like `pending_enrichment`, `TBD`, or `not_run`

## Browser Tool Tactics
Preferred sequence:
- `take_snapshot` or `take_enhanced_snapshot` to understand the inbox/thread
- `get_page_content` when extracting readable text from long content
- `click` only after snapshotting
- verify after each navigation or click

If the inbox list is unstable or partially hidden:
- use what is reliably visible first
- do one bounded load-more pass if useful
- stop when quality drops

## What Good Looks Like
A strong row is one where you can answer:
- who is this?
- what did I send?
- did they reply?
- who owes the next move?
- why is follow-up needed?
- how reliable is this row?
- when was it captured and by which run?

## Common Mistakes to Avoid
- one giant flat message sheet with no audit trail
- overwriting message history
- using names as the only key
- filling every optional field before writing anything
- endless retries during connector instability
- opening every thread even when preview already tells enough
- mixing operator view and raw event log without separation

## Best Practical Operating Pattern
1. Backfill recent visible outreach fast
2. Add trackability metadata immediately
3. Log the run in `Import_Log`
4. Enrich only top-priority rows
5. Repeat with bounded passes
6. Transition from preview capture to thread/profile enrichment over time

## Outcome
If followed well, this workflow produces:
- a fast operator table
- normalized history underneath
- clear next actions
- durable auditability
- minimal wasted work
- no stupid retries

---
name: linkedin-inbox-preview-backfill
description: Backfill recent LinkedIn outreach into the single Outreach sheet using inbox preview data first, minimal row fields, and selective deepening only when needed.
metadata:
  display-name: LinkedIn Inbox Preview Backfill
  enabled: "true"
  version: "1.2"
---

# LinkedIn Inbox Preview Backfill

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose
Populate the `Outreach` sheet quickly from recent LinkedIn conversations without opening every thread.

This is the right starting mode when:
- the sheet is empty or mostly empty
- the user wants recent outreach loaded fast
- speed matters more than perfect enrichment on the first pass

## Core rule
Start with the inbox preview. Open threads or profiles only when the preview is not enough to create a useful row.

## One-sheet rule
Write into the existing `Outreach` sheet only.

Do not create:
- import tabs
- review tabs
- enrichment tabs
- workflow notes tabs
- any other sheet just because the import is iterative

Iterative work should improve the same rows over time.

## Target output
A preview-backfill row is good enough if it captures most of:
- `added_on`
- `full_name`
- `profile_url` if visible, otherwise blank
- `stage`
- `last_contact_on`
- `last_contact_direction`
- `next_action`
- `notes`

It is acceptable for these to remain blank on the first pass:
- `profile_url`
- `title`
- `company`
- `next_action_on`
- `thread_url`

If both `profile_url` and `thread_url` are missing, do not merge into an existing row by name alone. Create an unresolved row or mark the row `needs_review`.

## Required sheet structure
Follow the schema from `linkedin-outreach-sheet-workflow`.
Do not create `Outreach_Table`, `Import_Log`, or extra helper tabs.

## Recommended bounds
Default first pass:
- backfill the most recent 30-50 conversations
- do at most one bounded load-more pass unless the user asks for deeper history
- retry each inbox interaction at most once

## What to capture from each conversation tile
If visible, collect:
- name
- visible activity date/time marker
- preview line
- whether the preview starts with `You:`
- unread or fresh activity signal
- thread URL if easy to capture

Use preview text only transiently to classify direction and action. Do not write or report private message snippets unless the user specifically asks for exact text.

## How to map preview rows into the sheet

### If preview begins with `You:`
Use:
- `stage = Messaged`
- `last_contact_direction = outbound`
- `next_action = Follow up` when follow-up is likely, otherwise blank
- `notes = preview_only`

### If preview begins with the other person's name
Use:
- `stage = Replied`
- `last_contact_direction = inbound`
- `next_action = Reply`
- `notes = preview_only`

### If preview is ambiguous
Use the best safe row you can and mark:
- `notes = needs_review`

Do not invent detail just to complete a row.

## Upsert strategy
For each person:
1. match by normalized `profile_url` when available
2. otherwise match by `thread_url` if available
3. otherwise do not merge automatically; add a new unresolved row or mark `needs_review`
4. add or update only the useful changed fields

## When to open a thread or profile
Open a thread or profile only when one of these is true:
- the row is high value
- the correct person is ambiguous
- `profile_url` is needed for deduplication
- the reply state materially affects the next action

## Anti-waste rules
- do not open every thread
- do not force full enrichment during the first pass
- do not create logging infrastructure
- do not rerun the entire batch when only a few cells failed
- stop when the marginal quality becomes poor

## What happens next
After preview backfill:
- use `linkedin-row-enrichment` for better profile/title/company coverage
- use `linkedin-outreach-daily-ops` for ongoing updates
- keep improving the same sheet instead of branching into new ones

---
name: linkedin-outreach-daily-ops
description: Run simple day-to-day LinkedIn outreach maintenance by checking what changed, updating only affected Outreach rows, and keeping next actions current.
metadata:
  display-name: LinkedIn Outreach Daily Ops
  enabled: "true"
  version: "1.2"
---

# LinkedIn Outreach Daily Ops

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose
Operate the simple `Outreach` sheet after setup or backfill is complete.

This skill is for maintenance, not rebuilding the sheet every day.

## One-sheet rule
Daily ops should update the same `Outreach` sheet.
Do not create daily log sheets, due sheets, reply sheets, or workflow history sheets.

## Daily goals
A good daily run should answer:
- who changed since the last check?
- who replied?
- who needs follow-up?
- which rows need a little enrichment before action?

## Core loop
1. scan the LinkedIn inbox preview
2. identify new or changed conversations
3. skip clearly unchanged rows
4. open only the threads that affect action
5. update the matching sheet rows
6. refresh `next_action_on` and `next_action`

## Delta rules
Open a thread only if:
- there is a new unread signal
- the preview changed materially
- a follow-up is due and exact context matters
- the row is important and still ambiguous

Skip a thread if:
- the preview is unchanged
- no decision depends on deeper context
- the row was already handled in the current run

## Row update rules
- if the latest touch is inbound, usually move `stage` to `Replied` and set `next_action = Reply`
- if the latest touch is outbound, usually keep `stage = Messaged` and decide whether `next_action = Follow up`
- if the relationship cools off, consider `stage = Nurture`
- if the thread is done, use `stage = Closed` and clear next actions

## Sheet discipline
- update only changed rows
- keep the single-sheet schema
- do not create import logs or helper tabs
- keep notes short
- prefer connector updates first, browser fallback only when necessary

## Good daily run output
At the end of a run, you should be able to say:
- how many rows were added
- how many rows were updated
- which follow-ups are due
- which rows still need review
- use row numbers or redacted labels in chat summaries unless the user asks for names, profile URLs, or thread URLs

## Anti-churn rules
- never rewrite the whole sheet each day
- never create extra status systems outside the main stage values
- never deepen every conversation by default
- never turn the sheet into a noisy event log
- never branch daily maintenance into multiple sheets

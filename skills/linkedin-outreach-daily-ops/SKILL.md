---
name: linkedin-outreach-daily-ops
description: Run LinkedIn outreach tracking as an ongoing operating loop using delta thinking, queueing, and controlled browser-to-sheet updates.
metadata:
  display-name: LinkedIn Outreach Daily Ops
  enabled: "true"
  version: "1.0"
---

# LinkedIn Outreach Daily Ops

## Purpose
Operate the LinkedIn outreach system after initial setup and first backfill are complete.

This skill is about **maintenance, monitoring, and actioning**, not just ingestion.

## Daily operating goals
A good daily run should answer:
- what changed since last run?
- who replied?
- who still needs follow-up?
- what should be enriched next?
- what can be skipped safely?

## Core loop
1. scan LinkedIn inbox preview
2. identify changed or new threads
3. skip unchanged rows
4. open only priority threads
5. update state
6. update queue / next actions
7. stamp verification metadata
8. log the run

## Delta-thinking rules
Do not treat every day like a first import.

Open a thread only if:
- there is a new unread signal
- the preview changed
- the row is high priority and still weakly enriched
- follow-up is due and exact context is needed
- previous review notes say the row was ambiguous

Skip a thread if:
- the row was already verified recently
- preview is unchanged
- no action depends on deeper context
- the thread was handled successfully in the same run

## Recommended statuses for daily operation
- `waiting_on_reply`
- `replied`
- `active_conversation`
- `followup_due`
- `needs_review`
- `archived`

## Queue / Next Action ideas
Use values like:
- `reply`
- `follow_up`
- `enrich_profile`
- `review_manually`
- `archive`
- `none`

## Follow-up handling
If the row is outbound-last-touch and still waiting:
- preserve the last outbound
- keep or create a draft
- update follow-up reason
- mark whether enrichment should happen before sending the next touch

If the row becomes inbound-last-touch:
- flip `Awaiting Reply From` to `me`
- change `Status` to `replied` or `active_conversation`
- consider drafting the next reply only if useful

## Verification policy
Update `Last Verified At` whenever:
- the preview is rechecked and deemed unchanged
- the thread is opened and reviewed
- the profile is opened and confirmed

This matters because it tells you whether the row is stale even if nothing changed.

## Daily import logging
Create a new `Import_Log` row per run with:
- Import Run ID
- Imported At
- Source = linkedin
- Mode = daily_delta
- Rows Added
- Rows Updated
- Confidence summary
- Notes

## Good daily run output
At the end of a run, you should be able to say:
- X rows added
- Y rows updated
- Z rows skipped as unchanged
- these high-priority follow-ups remain
- these rows still need enrichment

## Anti-churn rules
- never rewrite all rows every day
- never drop confidence just because the connector or UI is flaky
- never deepen every conversation by default
- never convert a clean operator table into a noisy event dump

## When to escalate to enrichment mode
Switch to `linkedin-row-enrichment` when:
- a row becomes strategically important
- title/company/profile URL are needed before follow-up
- preview context is no longer enough
- confidence must move from medium to high

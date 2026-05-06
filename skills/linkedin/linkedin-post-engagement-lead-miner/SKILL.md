---
name: linkedin-post-engagement-lead-miner
description: >-
  Mine engagement on a LinkedIn post, including reactions, comments, reposts,
  and visible profiles, to identify recruiters, hiring managers, employees,
  warm leads, reply opportunities, and follow-up actions. Use after publishing
  or reviewing a post; stop before messaging, connecting, or commenting unless
  explicitly confirmed.
metadata:
  display-name: LinkedIn Post Engagement Lead Miner
  enabled: "true"
  version: "1.0"
---

# LinkedIn Post Engagement Lead Miner

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this when a LinkedIn post has reactions, comments, or reposts that may contain opportunity signals or warm contacts.

## What To Extract

From the post and engagement surfaces:

- commenters and comment text
- reaction profiles when visible
- reposts or quoted reposts
- recruiters, hiring managers, founders, employees, professors, or relevant operators
- company names, titles, locations, and profile URLs when accessible
- warm-hook reason: comment content, reaction type, shared interest, company relevance, or hiring signal

## Procedure

1. Open the exact post URL.
2. Verify the post identity.
3. Capture visible post text, date, author, and engagement counts.
4. Inspect comments first because they carry strongest context.
5. Inspect reactions/reposts only as far as needed for useful leads.
6. Deduplicate by profile URL when possible.
7. Score leads and propose next actions.

## Lead Scoring

Use:

- `5`: direct hiring/recruiting/research opportunity signal
- `4`: relevant employee, professor, founder, or manager with clear hook
- `3`: plausible warm contact but weak action path
- `2`: low-fit or generic engagement
- `1`: irrelevant, spam, or not actionable

## Safety

Do not:

- message, connect, comment, or endorse without explicit approval
- scrape private data beyond what is visible in the current BrowserOS session
- merge people by name alone
- assume job authority from title without supporting evidence

## Output Schema

```text
Post URL:
Post summary:
Engagement reviewed:
Top leads:
- Name/profile:
  Title/company:
  Signal:
  Score:
  Suggested action:
Duplicates/skipped:
Recommended follow-up:
```

When tracking is requested, hand off to the outreach sheet or Obsidian workflow.


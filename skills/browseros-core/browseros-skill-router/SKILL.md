---
name: browseros-skill-router
description: >-
  Route BrowserOS work to the best existing skill, built-in skill, connected-app
  action, browser UI workflow, local file workflow, or unknown-site learning
  protocol. Use at the start of complex, multi-app, unfamiliar-site, or
  automation-heavy requests to avoid repetitive failed actions.
metadata:
  display-name: BrowserOS Skill Router
  enabled: "true"
  version: "1.0"
---

# BrowserOS Skill Router

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this as the first layer for complex BrowserOS tasks. It chooses the smallest reliable workflow before touching the page.

## Fast Decision

Before opening or clicking anything, choose one route:

```text
Known specific skill > connector action > known-site registry > browser UI > first-time exploration
```

Use the browser only when the task needs visual state, uploads/downloads,
authenticated UI, or final dashboard verification. Use local files/commands when
they answer faster than page inspection.

## Routing Order

1. **Known custom skill**: Use the most specific installed skill when one matches the site, task, safety model, or artifact. Known workflows do not need generic first-time exploration first.
2. **First-time site check**: If the domain/site family or workflow family is not covered by a known skill or registry entry, run `browseros-new-site-learning-protocol` before full automation.
3. **Connector first**: If the task belongs to a connected app and structured actions may exist, use `connector-first-action-discovery`.
4. **Built-in skill**: Use built-ins for generic extraction, form fill, monitoring, screenshots, bookmarks, tab organization, page saving, summarization, or deep research when no custom skill adds important behavior.
5. **Unknown site**: If no skill fits, use `browseros-new-site-learning-protocol`.
6. **Local/private state**: Use private memory or local files only when the task depends on approved answers, previous outreach state, local CVs, or short-lived run state. For durable long-term memory, use `obsidian-long-term-memory-workflow`.
7. **Live learning**: After substantial runs, use `browseros-skill-evolution-loop` to capture reusable insights and promote verified ones.

## Common Skill Chains

- Unknown job portal: `job-portal-application-workflow` -> `browseros-new-site-learning-protocol` -> `application-answer-bank-protocol`.
- Connected mail or sheets: `connector-first-action-discovery` -> Gmail/Outlook/Sheets reliability skill -> web fallback only for proven gaps.
- Research opportunity: `research-opportunity-finder` -> `professor-lab-outreach-workflow` -> mail skill if outreach is approved.
- LinkedIn profile: `linkedin-profile-optimizer` -> stop before saving profile edits.
- LinkedIn post engagement: `linkedin-post-engagement-lead-miner` -> outreach tracker or messaging skill only after confirmation.
- LinkedIn unknown feature family: `linkedin-feature-learning-lab` -> `browseros-skill-evolution-loop` -> patch the narrowest LinkedIn skill only after verification.
- Unfamiliar site that taught a reusable pattern: `browseros-new-site-learning-protocol` -> `browseros-skill-evolution-loop`.
- Any task that needs durable memory: task skill -> `obsidian-long-term-memory-workflow` -> domain-specific Obsidian skill when one fits.

## Decision Checklist

Before acting, decide:

- Is the target known or unknown?
- Has this domain/site family and workflow family had a first-time exploration pass?
- Is the action read-only, draft-only, or external/final?
- Is there a connector for the app?
- Is there a private approved-answer or duplicate-check source needed?
- What visible state proves completion?
- Where should the run artifact be saved if findings matter?
- Does any result need long-term memory in Obsidian?

## Anti-Loop Rule

After two failed attempts with the same click, selector, form field, or navigation path:

- stop repeating the action
- take a fresh snapshot or enhanced snapshot
- inspect page content, links, DOM, or console as appropriate
- switch to direct URL, connector, reload, or unknown-site mapping
- record the failure in the run note if it may recur

If a direct URL, connector action, or local artifact can prove the same state
with fewer clicks, switch to it immediately after the first failed UI path.

## Output Standard

Report:

- chosen route and why
- skills used
- actions completed
- final visible state or artifact path
- blockers, if any
- whether a new or improved skill should be created
- any live insight captured for future runs

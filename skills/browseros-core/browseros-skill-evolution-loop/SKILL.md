---
name: browseros-skill-evolution-loop
description: >-
  Continuously improve BrowserOS skills from live runs by capturing verified
  site insights, connector gaps, direct URLs, selectors, safety boundaries,
  success signals, failure modes, and recovery paths, then deciding whether to
  write a run note, update private memory, patch an existing public skill, or
  propose a new skill.
metadata:
  display-name: BrowserOS Skill Evolution Loop
  enabled: "true"
  version: "1.0"
---

# BrowserOS Skill Evolution Loop

## Purpose

Use this after any BrowserOS run that teaches something reusable. The goal is live learning that improves future automation without polluting public skills with private or one-off details.

Default rule: **capture every useful insight, promote only verified and reusable insights.**

## Continuous Improvement Loop

Use this tight loop for skill QA:

```text
test a real flow -> capture one verified issue/shortcut -> patch the narrowest skill -> validate -> sync -> record the run note
```

Do not scan all historical runs by default. Use the current run evidence first,
then search old run notes only for a specific known pattern.

For large known sites with many feature families, such as LinkedIn, do not treat
every unknown branch as a fully new site. Use the site-specific feature-learning
skill first, record a compact feature ledger, and promote only the branch-level
insight that reduces future clicks, failures, guessing, or safety risk.

## What Counts As A Skill Insight

Capture when a live run reveals:

- a faster entry URL or URL parameter
- a reliable button/menu/field label
- a hidden file input, modal, or iframe behavior
- a connector action that works or a connector gap
- a final-action boundary or risky confirmation step
- a success signal such as toast text, confirmation page, saved state, or sent-state marker
- a failure signal such as stale filters, disabled buttons, draft reopening, upload ambiguity, or validation text
- a recovery path after a failed click, stale page, login, 2FA, rate limit, or modal trap
- a public-safe field rule or answer-bank mapping pattern
- a first-time site exploration result that should mark a domain/workflow family as known

## Promotion Ladder

Classify each insight:

- `run_note`: useful but one-off, uncertain, site-account-specific, or not yet verified.
- `private_memory`: personal path, private account preference, approved answer, duplicate state, or sensitive workflow detail.
- `site_registry`: public-safe domain/workflow learning that helps future agents know whether first-time exploration has already happened.
- `existing_skill_patch`: verified, generic, and directly improves an existing skill.
- `new_skill_candidate`: distinct repeatable workflow with its own trigger, safety model, or site family.
- `do_not_store`: secrets, credentials, one-time codes, private message content, or fragile speculation.

## Verification Gates

Patch a public skill only when:

- the insight was observed in a live run or connector call
- the state change was verified by UI, URL, extracted content, connector readback, artifact, or second pass
- the wording is generic and public-safe
- the change reduces future clicks, failures, guessing, or safety risk
- it does not conflict with a more specific existing skill

If confidence is medium, write a run note and mark it as `candidate_for_skill_patch` instead of patching immediately.

## Patch Discipline

When improving skills:

1. Patch the repo source of truth first, not only the installed skill.
2. Prefer updating the narrowest existing skill.
3. Create a new skill only for a distinct trigger or safety model.
4. Keep the patch concise: add the reusable rule, not the entire exploration story.
5. Update catalog/usage docs only when a skill is added, renamed, or materially changes routing.
6. Sync installed BrowserOS skills after validation.

## Public vs Private Split

Public skills may contain:

- generic URLs and URL patterns
- generic labels, controls, field classes, and failure modes
- generic safety rules and success indicators
- generic connector gaps

Private memory may contain:

- local paths
- personal default answers
- real recipients, profile URLs, account names, emails, phone numbers, or document names
- duplicate outreach/application state
- private notes about a specific run

Known-site registry may contain:

- domain or site family
- workflow family
- confidence
- safe entry URL
- final-action boundary
- success and failure signals
- related skill or run note
- last observed date

## End-Of-Run Reflection

At the end of substantial runs, answer:

```text
What new workflow fact did I learn?
Was it verified?
Is it generic or private?
Which future task will benefit?
Does it patch an existing skill?
Does it need a new skill?
Where did I store it?
```

## Output Standard

Report skill learning separately from task completion:

```text
Live insight:
Classification:
Stored in:
Skill updated:
Install/sync status:
Remaining validation needed:
```

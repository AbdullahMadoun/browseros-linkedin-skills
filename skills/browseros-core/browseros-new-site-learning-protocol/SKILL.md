---
name: browseros-new-site-learning-protocol
description: >-
  Learn an unfamiliar website or workflow in BrowserOS by mapping entry points,
  controls, forms, uploads, state changes, final-action boundaries, success
  signals, failure states, and recovery paths before doing full automation or
  creating/improving a reusable skill. Use when no existing skill fits a site or
  workflow, or when a domain/site family is being handled for the first time.
metadata:
  display-name: BrowserOS New Site Learning Protocol
  enabled: "true"
  version: "1.0"
---

# BrowserOS New Site Learning Protocol

## Purpose

Use this skill when BrowserOS is on a site without a known skill, or when the domain/site family has not been seen before. The goal is to learn the workflow safely before full automation.

Default mode: **explore, map, document, and stop before any external submit/send/publish/payment/delete action.**

## First-Time Site Rule

Every new domain or site family gets a first-time exploration pass before full task execution.

Treat a site as new when:

- the domain is absent from the private known-site registry
- the domain exists but the workflow family is new, such as search, application, checkout, dashboard edit, message send, upload, export, or profile edit
- the UI changed enough that prior instructions no longer match visible controls
- the agent has no reliable success signal or final-action boundary for the requested task

Private registry default: `~/.browseros/private/site-learning-registry.json`.

If the registry is unavailable, behave as if the site is new and write a run note instead of guessing.

## Start Conditions

Before interacting:

- Identify the exact task and target site.
- Check whether an existing custom or built-in skill already covers the workflow.
- Check whether the domain/site family is known in private memory or the known-site registry.
- Record the starting URL, page title, auth state, and visible task goal.
- If the site is app-like, call connector discovery first when a connected app may support the action.

## First-Time Exploration Pass

For a new site, do a bounded discovery pass:

1. Identify the site family: content, search, form, job portal, dashboard, mail, commerce, social, learning platform, or custom app.
2. Map navigation and obvious task entry points.
3. Inspect forms, required fields, upload/download controls, disabled buttons, and final-action labels.
4. Test only low-risk state changes such as opening menus, filters, drafts, previews, or non-final modals.
5. Identify what proves success and what proves danger.
6. Decide whether to continue the user task, ask for missing data, or stop at a boundary.

Keep this pass short unless the user explicitly asks for deep exploration.

## Least-Click Discovery Order

Prefer this evidence order before exploratory clicking:

```text
snapshot -> page content -> page links -> DOM search -> one low-risk click -> enhanced snapshot
```

Use direct URLs from links/content when available. Do not click through every
visible card if `get_page_links` or extracted content already exposes stable
detail URLs.

## Exploration Loop

Work one step at a time:

1. Take a fresh snapshot.
2. Record visible controls, forms, menus, links, upload buttons, and disabled actions.
3. Perform the lowest-risk next action.
4. Verify the state change through at least two signals when possible: URL, visible UI, modal title, enabled button, field value, toast, or extracted content.
5. Stop after two failed attempts with the same control and switch strategy: enhanced snapshot, DOM search, page content, reload, direct URL, or connector fallback.

Do not keep clicking the same control without new evidence.

## Workflow Map

Produce a compact map:

```text
Site:
Task:
Entry URLs:
Auth/account state:
Main pages or modals:
Controls and labels:
Fields and required markers:
Upload/download mechanics:
Final-action boundary:
Success indicators:
Failure indicators:
Fast path:
Fallback path:
Unknowns:
Registry update:
Recommended skill update:
```

## Boundaries

Always stop before:

- application submission
- sending messages or email
- posting publicly
- scheduling public content or email
- uploading sensitive documents to a final recipient
- payment, subscription, refund, billing, or checkout
- deleting, overwriting, publishing, inviting, or changing permissions

If the user explicitly authorizes the exact final action, use the relevant domain skill or a verified local action plan before proceeding.

## Field And Answer Handling

For application-like forms, use `application-answer-bank-protocol`.

Never invent:

- salary, notice period, sponsorship, work authorization, relocation, availability, or years of experience
- personal contact details not visible or approved
- degree status, certifications, dates, employers, titles, or metrics
- file choices or document versions

## Artifact Requirement

For substantial exploration, save a reusable run note in the workspace or configured runs folder. Keep it public-safe unless the user explicitly requests a private note.

The artifact should be concise enough to become a future skill, but detailed enough that another BrowserOS agent can repeat the workflow without rediscovery.

## Registry Update

After first-time exploration, update private memory or the known-site registry with:

- domain or site family
- workflow family
- confidence: low, medium, high
- safe entry URL
- final-action boundary
- success signal
- failure signal
- related skill or run note
- date last observed

Do not store secrets, private messages, private file names, real profile URLs, or personal application answers in the registry.

## Promotion Rule

After exploration, use `browseros-skill-evolution-loop`.

Create or improve a skill only when the workflow is repeatable, fragile, high-value, safety-sensitive, and verified. Otherwise, keep the run note as one-off learning or private memory.

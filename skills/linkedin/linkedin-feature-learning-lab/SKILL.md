---
name: linkedin-feature-learning-lab
description: >-
  Safely learn new LinkedIn feature families and improve existing LinkedIn
  BrowserOS skills by mapping direct entry URLs, controls, modals, filters,
  final-action boundaries, success signals, failure states, and fast paths
  without sending, posting, saving, inviting, applying, or uploading sensitive
  documents.
metadata:
  display-name: LinkedIn Feature Learning Lab
  enabled: "true"
  version: "1.0"
---

# LinkedIn Feature Learning Lab

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this skill when the user asks BrowserOS to learn LinkedIn capabilities,
explore a LinkedIn workflow not covered by a narrower skill, or make existing
LinkedIn skills faster and less repetitive.

This is for **safe feature-family learning**, not for completing final external
actions. It turns live observations into a reusable feature ledger and candidate
patches for narrower LinkedIn skills.

For the feature map and ledger format, load
`references/linkedin-feature-map.md`. For a copyable run artifact, use
`templates/linkedin-feature-ledger-template.md`.

## Critical Rules

1. Default to read-only or draft-only exploration.
2. Never click final or external actions such as `Send`, `Post`,
   `Submit application`, `Save`, `Done`, `Invite`, `Apply`, `Follow`,
   `Comment`, `Reply`, `React`, `Repost`, `Share`, `Accept`, `Ignore`,
   `Join`, `Register`, `Endorse`, `Request referral`, or destructive
   confirmations unless the user explicitly approves that exact action.
3. Never upload a sensitive document during exploration unless the requested
   task is specifically document staging and the user confirms the exact file.
4. Do not mass scrape, open excessive profiles, or repeat searches in a way that
   risks rate limits. Sample enough to learn the UI path.
5. Prefer improving the narrowest existing LinkedIn skill when the insight fits
   an existing workflow. Create a new skill only for a distinct trigger or
   safety model.
6. Store private account state, real profile URLs, message text, document names,
   and duplicate history only in private memory or private run notes.

## Fast Workflow

1. **Pick the feature family.** Classify the target as search, jobs, Easy Apply,
   company pages, people/profile, posts, comments/reactions, messaging, network,
   notifications, profile editing, documents, saved items, events, services, or
   ads/analytics.
2. **Choose the safest entry.** Prefer a direct LinkedIn URL, known tab URL,
   page link, or existing skill fast path before generic navigation.
3. **Inspect before clicking.** Use snapshot, page content, links, DOM search,
   and only then one low-risk click.
4. **Map one branch at a time.** Record the URL/state before and after each
   filter, tab, menu, modal, preview, upload chooser, or editor open.
5. **Stop at boundaries.** If a branch reaches a final action, record the label,
   disabled/enabled state, warning text, and verification signal, then back out.
6. **Find the fastest repeatable path.** Prefer URL parameters, stable tab links,
   menu labels, and modal titles over brittle coordinates.
7. **Compare to existing skills.** Decide whether the insight improves one
   existing LinkedIn skill, belongs in this feature ledger only, or needs a new
   skill proposal.
8. **Promote learning.** Use `browseros-skill-evolution-loop` to classify and
   store only verified reusable facts.

## Feature Branch Probe

For each branch, capture:

```text
Feature family:
Entry URL:
Starting state:
Controls seen:
Low-risk actions tried:
State changes:
Fast path:
Final-action boundary:
Success signals:
Failure or stale-state signals:
Recovery path:
Existing skill to patch:
Confidence:
```

## Stop And Recovery

- After two failed attempts on the same control, switch to page links, DOM
  search, direct URL, reload, or a narrower skill.
- If LinkedIn shows login, checkpoint, rate-limit, unavailable modal, or stale
  result state, stop feature exploration and record the condition.
- If a feature branch requires another person, document, post, or application
  state that is not already approved for the run, record it as `needs_user_data`
  instead of guessing.

## Output Standard

Save a concise run artifact with:

- feature families explored
- exact safe entry URLs
- fastest verified paths
- final-action boundaries
- success and failure signals
- candidate patches by skill name
- private items deliberately excluded
- remaining live tests needed

The run is successful when BrowserOS can repeat the learned branch with fewer
clicks, clearer stop points, and less rediscovery, without degrading the
narrower LinkedIn skills.

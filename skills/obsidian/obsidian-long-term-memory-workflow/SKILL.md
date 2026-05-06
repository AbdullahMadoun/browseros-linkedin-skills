---
name: obsidian-long-term-memory-workflow
description: >-
  Use when any BrowserOS skill, automation run, research pass, site learning,
  outreach workflow, application workflow, or local task needs durable long-term
  memory. Stores reusable knowledge in a user-approved Obsidian vault instead
  of relying on chat context, transient run notes, or ad hoc local files.
metadata:
  display-name: Obsidian Long-Term Memory Workflow
  enabled: "true"
  version: "1.0"
---

# Obsidian Long-Term Memory Workflow

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this whenever a workflow produces knowledge that should survive future
sessions: user preferences, stable decisions, site/workflow learning, duplicate
state, reusable research findings, application history, skill improvement
insights, or project memory.

Default rule: **if it matters later, write it to Obsidian or link to an Obsidian
note.**

## Vault Rule

Use the user-provided Obsidian vault path. Do not hardcode local machine paths.

If the vault path is unknown:

- ask for it when the memory is important for future work
- otherwise save a temporary run note and mark it `needs_obsidian_vault_path`
- do not pretend chat context is long-term memory

## What To Store

Store durable memory for:

- recurring user preferences and operating rules
- verified site workflows, direct URLs, final-action boundaries, and recovery
  paths
- duplicate outreach, application, lead, or document state
- reusable search keywords, rejected/noisy query patterns, and proven query
  patterns
- project-specific decisions and open loops
- skill improvement insights that are private, account-specific, or too detailed
  for public skills
- pointers to private files such as approved answer banks, without copying raw
  secrets into public notes

Do not store:

- passwords, tokens, cookies, one-time codes, recovery keys, or payment data
- unverified guesses
- private message bodies unless the user asks for that exact durable record
- sensitive personal answers in public repo files

## Note Placement

Prefer the most specific existing folder if the vault already has one. If no
structure exists, use:

```text
BrowserOS Memory/
  00 Inbox.md
  Sites/
  Workflows/
  Preferences.md
  Applications/
  Outreach/
  Research/
  Skill Improvements/
```

For job-search memory, use `obsidian-job-search-keyword-intelligence` when the
memory belongs to keyword maturity, leads, duplicate exclusions, outreach, or
application paths.

## Memory Record Shape

Use compact Markdown with frontmatter when creating a durable note:

```yaml
type: browseros_memory
date: YYYY-MM-DD
source: browseros_run
confidence: low | medium | high
scope: preference | site | workflow | application | outreach | research | skill
privacy: public_safe | private | sensitive_pointer
status: active | review | retired
```

Include:

- what was learned
- evidence or source run
- when to reuse it
- when not to reuse it
- related skill or workflow
- next review date if the fact may expire

## Workflow

1. Decide whether the memory is durable, private, and reusable.
2. Choose the narrowest Obsidian note or create one under `BrowserOS Memory/`.
3. Write only the minimum useful fact, with evidence and confidence.
4. Link to run artifacts instead of pasting long logs.
5. If public skills should change, use `browseros-skill-evolution-loop` after
   the Obsidian note is saved.
6. Report the note path or `needs_obsidian_vault_path`.

## Output Standard

When memory is saved, report:

```text
Long-term memory:
Obsidian note:
Privacy:
Reused by:
Still needed:
```

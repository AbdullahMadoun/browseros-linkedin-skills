# Contributing

Contributions should make BrowserOS better at repeatable workflows. A good contribution captures a task that would otherwise require rediscovering buttons, menus, URLs, connector actions, safety checks, or verification steps every time.

## Ways To Contribute

| Contribution | Use When | Expected Output |
|---|---|---|
| New skill | A workflow is repeatable and distinct from existing skills. | New `skills/<group>/<skill-name>/SKILL.md` plus docs updates. |
| Skill improvement | An existing skill is slow, brittle, incomplete, or missing a better path. | Patch the existing `SKILL.md` and update docs if behavior changes. |
| Workflow exploration | A workflow has not been fully mapped yet. | Notes that identify reliable paths, slow paths, buttons, modals, and success signals. |
| Safety audit | A skill sends, submits, uploads, schedules, deletes, or edits data. | Added confirmation points, stop conditions, and verification rules. |
| Public cleanup | A skill contains private examples or account-specific details. | Generic examples and a clean privacy scan. |
| Documentation | Users need clearer discovery or usage chains. | Updates to `README.md`, `docs/`, or group indexes. |
| Live skill evolution | A real BrowserOS run reveals a reusable path, gap, or failure mode. | Run note, private-memory update, existing-skill patch, or new skill candidate. |

## New Skill Workflow

Start with the exploration prompt:

```text
We will explore [workflow]. Try it out, try all buttons and clicks, learn everything about it to find an optimal method of usage and all features related to it. Try it extensively using all paths possible, all clicks, and all buttons.
```

Then ask for an improvement pass:

```text
Any improvement areas or any paths that feel uncomfortable or slow to use? If applicable, do another pass of improvement.
```

Then ask to add the skill:

```text
Add it to my skills. Make sure there is minimal overlap with existing ones and report to me any issues.
```

## Before Adding A Skill

Check:

- Does an existing skill already cover this workflow?
- Is this a distinct trigger, or just a small variant?
- Does the workflow have a reliable normal path?
- Are fallback paths documented?
- Are send/submit/upload/delete/schedule steps guarded by explicit confirmation?
- Is success verified from UI, connector state, or output artifacts?
- Are private names, paths, filenames, profile URLs, and account details removed?

## Folder Placement

Place new skills under the closest group:

| Group | Path |
|---|---|
| BrowserOS routing, unknown-site learning, connectors, answer bank, and skill evolution | `skills/browseros-core/<skill-name>/` |
| LinkedIn workflows | `skills/linkedin/<skill-name>/` |
| External job portals and company career pages | `skills/job-portals/<skill-name>/` |
| Gmail workflows | `skills/gmail/<skill-name>/` |
| Google Sheets workflows | `skills/google-sheets/<skill-name>/` |
| Obsidian workflows | `skills/obsidian/<skill-name>/` |
| Outlook workflows | `skills/outlook/<skill-name>/` |
| Research opportunities and professor/lab outreach | `skills/research-opportunities/<skill-name>/` |
| Resume and application-material workflows | `skills/resume-application/<skill-name>/` |
| General search, scoring, and lead processing | `skills/search-leads/<skill-name>/` |

The installer scans these groups recursively and installs each skill as a top-level BrowserOS skill folder.

## Required Files

Every skill needs:

```text
skills/<group>/<skill-name>/SKILL.md
```

The front matter must include:

```yaml
---
name: skill-folder-name
description: Clear trigger description for when to use this skill.
---
```

The `name` value must match the skill folder name exactly.

## Docs To Update

When a skill is added, removed, renamed, or materially changed, update:

- `README.md`
- `skills/README.md`
- `docs/SKILL_CATALOG.md`
- `docs/USAGE_IDEAS.md`
- `docs/REPO_STRUCTURE.md` if placement rules change

Run `docs/PUBLICATION_AUDIT.md` before publishing.

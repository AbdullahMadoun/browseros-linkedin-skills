# Repository Structure

This repository is organized so users can quickly install skills, understand what each skill does, and safely add new workflows.

## Top-Level Layout

```text
.
├── README.md
├── CONTRIBUTING.md
├── docs/
├── scripts/
└── skills/
```

## Root Files

| Path | Purpose |
|---|---|
| `README.md` | Public overview, installation, skill groups, and maintenance rules. |
| `CONTRIBUTING.md` | How to contribute new skills, improvements, docs, audits, and workflow exploration. |
| `.gitignore` | Keeps generated or local-only files out of the repo. |

## `skills/`

Skills are grouped visually by use case. Each leaf folder containing a `SKILL.md` is one BrowserOS skill package.

Required:

```text
skills/<group>/<skill-name>/SKILL.md
```

Current groups:

| Group | Purpose |
|---|---|
| `skills/linkedin/` | LinkedIn search, outreach, messaging, Easy Apply, and LinkedIn-specific application workflows. |
| `skills/google-sheets/` | Google Sheets connector reliability and sheet operations. |
| `skills/gmail/` | Gmail connector-first mail workflows and Gmail web fallback operations. |
| `skills/outlook/` | Outlook mail drafting, attachment, sending, scheduling, and verification. |
| `skills/resume-application/` | Resume, cover letter, ATS, hallucination audit, draft review, and interview prep workflows. |
| `skills/search-leads/` | General search hygiene, scoring, deduplication, and pivot planning. |

Allowed supporting files:

- scripts that make a workflow deterministic
- templates used by the skill
- manifests or config examples
- small reference files that the skill explicitly points to

Do not add unrelated READMEs inside individual skill package folders. Group-level README files are allowed for navigation. Public explanation belongs in root/docs indexes; execution behavior belongs in `SKILL.md`.

## `docs/`

Public documentation lives here.

| Path | Purpose |
|---|---|
| `docs/README.md` | Documentation index. |
| `docs/BROWSEROS_INSTALLATION.md` | BrowserOS provider setup, model override, test step, and Assistant install prompt. |
| `docs/SKILL_CATALOG.md` | Complete grouped catalog of all skills. |
| `docs/USAGE_IDEAS.md` | Common skill chains and workflows. |
| `docs/SKILL_IMPROVEMENT_WORKFLOW.md` | How to explore a workflow and turn it into a skill. |
| `docs/PUBLICATION_AUDIT.md` | Pre-publication audit checklist. |
| `docs/REPO_STRUCTURE.md` | This structure guide. |
| `docs/assets/` | Public-safe screenshots and other small documentation assets. |

Do not keep old import notes, source-coverage maps, private package references, or local-only notes in public docs.

## `scripts/`

Automation that helps install or validate the repo lives here.

Current script:

- `install-browseros-skills.ps1` copies skill folders into a BrowserOS skills directory.

## Naming Rules

- Skill folder names use lowercase kebab-case.
- `SKILL.md` front matter `name` must match the folder exactly.
- Use public, generic names such as `resume-hallucination-risk-audit`.
- Avoid personal terms, local machine references, and private project names.

## Update Flow

1. Add or edit the relevant skill folder under `skills/<group>/`.
2. Update `skills/README.md`.
3. Update `docs/SKILL_CATALOG.md`.
4. Update `docs/USAGE_IDEAS.md` if the skill changes common workflows.
5. Update `CONTRIBUTING.md` or `docs/SKILL_IMPROVEMENT_WORKFLOW.md` if the contribution process changes.
6. Run `docs/PUBLICATION_AUDIT.md`.
7. Wait for explicit user approval before pushing.

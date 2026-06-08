# 🤖 BrowserOS Skills Suite

![Version](https://img.shields.io/badge/Version-1.0-blue)
![Platform](https://img.shields.io/badge/Platform-BrowserOS-purple)
![Skills](https://img.shields.io/badge/Skills-42-success)

Public BrowserOS skill packages for BrowserOS routing, unknown-site learning, connector-first actions, LinkedIn search and outreach, job applications, research opportunities, resume tailoring, Gmail and Outlook mail workflows, Google Sheets reliability, Obsidian long-term memory, Obsidian job-search intelligence, and grounded application-material review.

The repository is organized as one skill per leaf folder under `skills/<group>/`. Each skill has a `SKILL.md` file with BrowserOS-compatible front matter and concise instructions for an agent to follow.

---

## 📦 What Is Included

This repo includes **42 custom skills**:

- **BrowserOS core workflows:** skill routing, first-time site exploration, unknown-site learning, connector-first action discovery, private approved-answer bank handling, and live skill evolution.
- **Search and lead discovery:** LinkedIn people search, Boolean refinement, KSA hiring posts, company mapping, hiring-post comment mining, scoring, deduplication, and search-state hygiene.
- **Obsidian knowledge base workflows:** long-term BrowserOS memory, keyword maturity, search logs, duplicate exclusions, lead notes, application paths, and graph-friendly job-search intelligence.
- **Outreach operations:** one-sheet Google Sheets outreach tracking, inbox preview backfill, row enrichment, daily operations, LinkedIn messaging, connection requests, document attachment, profile optimization, post-engagement lead mining, safe post preparation, and LinkedIn feature learning.
- **Job application support:** LinkedIn Easy Apply, generic job portals, job/CV fit and keyword review, batch shortlist tailoring, local LaTeX resume tailoring, cover letters, hallucination audits, final-draft review, and interview prep.
- **Research opportunity workflows:** credible AI/CS research opportunity search and professor/lab outreach preparation.
- **Gmail workflows:** connector-first search/read/draft/send/reply reliability, received attachment extraction, label cleanup, web fallback for outgoing attachments, scheduled send, draft editing, and label management.
- **Outlook workflows:** connector-first draft/send reliability, local file attachment in Outlook web, and scheduled send verification.

> *Note: BrowserOS built-in skills are not vendored here. This repo is for custom reusable workflows.*

---

## 📂 Repository Layout

```text
browseros-linkedin-skills/
├── CONTRIBUTING.md
├── skills/
│   ├── google-sheets/
│   ├── browseros-core/
│   ├── gmail/
│   ├── job-portals/
│   ├── linkedin/
│   ├── obsidian/
│   ├── outlook/
│   ├── research-opportunities/
│   ├── resume-application/
│   └── search-leads/
├── docs/
│   ├── README.md
│   ├── BROWSEROS_INSTALLATION.md
│   ├── PUBLICATION_AUDIT.md
│   ├── REPO_STRUCTURE.md
│   ├── SKILL_IMPROVEMENT_WORKFLOW.md
│   ├── SKILL_CATALOG.md
│   └── USAGE_IDEAS.md
└── scripts/
    ├── install-browseros-skills.ps1
    ├── install-browseros-skills.sh
    └── validate-browseros-skills.sh
```

---

## 🔒 Safety Defaults

These skills are intentionally conservative:

- ❌ **No hallucinations:** They do not invent resume facts, credentials, metrics, employers, dates, or outcomes.
- ❌ **No guessing:** They do not guess application answers such as salary, authorization, sponsorship, relocation, availability, notice period, years of experience, or document choice.
- ✅ **Explicit confirmation:** They require explicit confirmation before final application submission.
- ✅ **Data sensitivity:** They treat names, profile URLs, email addresses, phone numbers, message snippets, private filenames, and application materials as sensitive.
- ✅ **Redacted logs:** They prefer redacted labels in chat summaries unless exact identifiers are required.
- ✅ **State verification:** They verify UI state before sending messages, uploading sensitive documents, scheduling emails, or marking work complete.

---

## 🚀 BrowserOS Setup And Installation

Use this path when setting up BrowserOS for these skills from the browser UI.

1. Open the Assistant tab, click settings, and go to BrowserOS AI provider settings.
2. Choose the `ChatGPT Plus/Pro` quick provider template and complete login.

![BrowserOS provider settings with ChatGPT Plus/Pro template](docs/assets/browseros-provider-settings.png)

3. *Optional dev tip:* click `Edit` on the provider card and override the frontend model to `gpt-5.5` if it is available on your account.

![BrowserOS edit provider model settings](docs/assets/browseros-provider-edit-model.png)
![BrowserOS model dropdown](docs/assets/browseros-provider-model-dropdown.png)

4. Click `Test` on the provider card or inside the edit dialog. Do not continue until the provider test works.
5. Open the Assistant tab and send:

```text
Install this repo and add them as skills:
https://github.com/AbdullahMadoun/browseros-linkedin-skills

After installing, update persistent memory to know exactly how to utilize them.
```

*(If installing from a fork, replace the GitHub URL with the fork URL.)*

> See [docs/BROWSEROS_INSTALLATION.md](docs/BROWSEROS_INSTALLATION.md) for the full step-by-step setup notes and verification checklist.

---

## 🛠️ Manual Installation

From the repository root on **Windows**:
```powershell
.\scripts\install-browseros-skills.ps1
```

From **macOS / Linux**:
```bash
./scripts/install-browseros-skills.sh
```

By default, the scripts copy only missing skills into:
- Windows: `$env:USERPROFILE\.browseros\skills`
- macOS/Linux: `$HOME/.browseros/skills`

**Advanced options:**
```bash
# Overwrite existing installed skills
./scripts/install-browseros-skills.sh --overwrite

# Remove stale skill folders
./scripts/install-browseros-skills.sh --overwrite --prune

# Validate before publishing
./scripts/validate-browseros-skills.sh
```

---

## 📚 Usage

- **Start here:** [docs/README.md](docs/README.md)
- **Full skill list:** [docs/SKILL_CATALOG.md](docs/SKILL_CATALOG.md)
- **Common chains:** [docs/USAGE_IDEAS.md](docs/USAGE_IDEAS.md)
- **Create/improve a skill:** [docs/SKILL_IMPROVEMENT_WORKFLOW.md](docs/SKILL_IMPROVEMENT_WORKFLOW.md)
- **Repository org changes:** [docs/REPO_STRUCTURE.md](docs/REPO_STRUCTURE.md)
- **Contribution guide:** [CONTRIBUTING.md](CONTRIBUTING.md)

---

## 🤝 Contributing

Useful contributions include adding new skills, improving existing ones, or documenting workflow explorations.

**Recommended workflow prompt:**
```text
We will explore [workflow]. Try it out, try all buttons and clicks, learn everything about it to find an optimal method of usage and all features related to it. Try it extensively using all paths possible, all clicks, and all buttons.
```

**Improvement pass:**
```text
Any improvement areas or any paths that feel uncomfortable or slow to use? If applicable, do another pass of improvement.
```

**Final check:**
```text
Add it to my skills. Make sure there is minimal overlap with existing ones and report to me any issues.
```

---

## 📦 Public Repo Maintenance

Before publishing updates:
1. Use the exploration-first process in [docs/SKILL_IMPROVEMENT_WORKFLOW.md](docs/SKILL_IMPROVEMENT_WORKFLOW.md).
2. Add/update one skill per folder under `skills/<group>/`.
3. Keep `SKILL.md` front matter valid and match `name` to the folder name.
4. Remove personal paths, names, private filenames, and local machine details.
5. Update `README.md`, `skills/README.md`, `docs/SKILL_CATALOG.md`, and `docs/USAGE_IDEAS.md`.
6. Run the audit checks in [docs/PUBLICATION_AUDIT.md](docs/PUBLICATION_AUDIT.md).

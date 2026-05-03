# Merge Notes

## Merge Date

2026-04-27

## Sources

### Local BrowserOS skills

Source path:

```text
<local-browseros-skills-dir>
```

Merged skills:

- `google-sheets-connector-reliability`
- `linkedin-attach-document-workflow`
- `linkedin-connection-workflow`
- `linkedin-inbox-preview-backfill`
- `linkedin-messaging-workflow`
- `linkedin-outreach-daily-ops`
- `linkedin-outreach-sheet-workflow`
- `linkedin-row-enrichment`

### Archived search-agent skills

Source archive:

```text
<search-agent-skills-archive>
```

Extracted staging path:

```text
<search-agent-skills-staging-dir>
```

Merged skills:

- `lead-scoring-dedup-pivots`
- `linkedin-boolean-query-refinement`
- `linkedin-ksa-recent-hiring-posts`
- `linkedin-people-url-filtering`
- `search-state-verification-hygiene`

Preserved supporting files:

- `manifest.json`
- `templates.md`
- `presets.md`
- `build_people_search_url.py`
- `QUERY_PACK_TEMPLATE.md`
- `config.template.json`
- `templates/results_template.csv`
- `templates/run_log_template.md`

## Normalization Performed

The archived search-agent `SKILL.md` files did not include BrowserOS YAML front matter. BrowserOS-style front matter was added to these files:

- `skills/lead-scoring-dedup-pivots/SKILL.md`
- `skills/linkedin-boolean-query-refinement/SKILL.md`
- `skills/linkedin-ksa-recent-hiring-posts/SKILL.md`
- `skills/linkedin-people-url-filtering/SKILL.md`
- `skills/search-state-verification-hygiene/SKILL.md`

The original skill bodies were preserved below the added front matter.

## Removal Policy

No source skill was intentionally removed during this merge.

Future removals should be handled explicitly:

1. Identify the skill or file proposed for removal.
2. Explain why it is obsolete, duplicated, or harmful.
3. Ask for approval before deleting it.
4. Record the decision in this file.

## Conflict Policy

If a future archive contains a skill with the same directory name:

1. Do not overwrite blindly.
2. Compare `SKILL.md`, manifest, templates, and scripts.
3. Preserve both versions temporarily if behavior differs.
4. Merge only after documenting what changed.

## Local Refresh

### 2026-05-03

Source path:

```text
<local-browseros-skills-dir>
```

Reviewed local skills against the GitHub repo and kept the normalized repo versions where local files were older, disabled, or malformed. Notable decisions:

- Preserved the cleaned repo copy of `linkedin-messaging-workflow` because the local copy contained duplicated escaped front matter.
- Preserved repo metadata, versions, manifests, templates, and helper scripts for existing skills.
- Replaced `linkedin-ksa-recent-hiring-posts/SKILL.md` with the newer local LinkedIn-first candidate-fit workflow.
- Updated the KSA skill manifest, config, query pack, and result/log templates to match the v1.2 workflow.
- Merged the local single-sheet outreach model into `linkedin-outreach-sheet-workflow` as an explicit lightweight mode instead of replacing the existing normalized workbook model.
- Added `local-latex-resume-tailoring` as a job-application support skill.

### 2026-05-04 anonymization

Removed user-specific paths, repository-owner URLs, names, and resume details from repo documentation and the local LaTeX resume tailoring skill.

### 2026-05-04

Reviewed the outreach skills again and found inconsistent defaults between the simple `Outreach` sheet model and the older normalized workbook model.

Updated these skills to make one-sheet `Outreach` tracking the default:

- `google-sheets-connector-reliability`
- `linkedin-connection-workflow`
- `linkedin-inbox-preview-backfill`
- `linkedin-outreach-daily-ops`
- `linkedin-outreach-sheet-workflow`
- `linkedin-row-enrichment`

Kept normalized multi-tab tracking as optional advanced guidance only when explicitly requested.

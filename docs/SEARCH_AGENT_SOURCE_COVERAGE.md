# Source Coverage Map

Every source file found under the three BrowserOS session folders was reviewed and mapped into the output skills.

## Session `4ca1f790-9b43-4aa3-b85b-10ff971e57d1`

- `linkedin_people_search_workflow_v1.md`
  - Mapped to `linkedin-people-url-filtering` and `search-state-verification-hygiene`.
  - Preserved: direct People entry, quick-chip order, All filters last, sticky filter reset, speed vs precision decision rule.

- `linkedin_people_search_workflow_v2.md`
  - Mapped to `linkedin-people-url-filtering`.
  - Preserved: clean People URL without `origin`, verified `network=["S"]`, Riyadh `geoUrn=["101336206"]`, reset/URL hygiene, anti-patterns.

- `linkedin_people_search_workflow_v3.md`
  - Mapped to `search-state-verification-hygiene` and `linkedin-people-url-filtering`.
  - Preserved: verification-first loop, one filter layer at a time, URL/result delta validation, clean-start protocol.

- `linkedin_people_search_workflow_v4.md`
  - Mapped to `linkedin-people-url-filtering` and `search-state-verification-hygiene`.
  - Preserved: presets, URL builder, click-budget/run-card standards, URL-lock fallback when chips are inconsistent.

- `skills/linkedin-people-search/SKILL.md`
  - Mapped primarily to `linkedin-people-url-filtering`.
  - Preserved: People-first golden rule, light-to-heavy filter sequence, URL signals, runbook, output schema, presets, drift handling.

- `skills/linkedin-people-search/templates.md`
  - Mapped to `linkedin-people-url-filtering/templates.md` and `search-state-verification-hygiene/templates.md`.
  - Preserved: URL templates, query templates, run card, click-budget targets.

- `skills/linkedin-people-search/presets.md`
  - Mapped to `linkedin-people-url-filtering/presets.md`.
  - Preserved: networking Riyadh, target account Riyadh, broad Saudi mapping, strict shortlist.

- `skills/linkedin-people-search/build_people_search_url.py`
  - Mapped to `linkedin-people-url-filtering/build_people_search_url.py`.
  - Preserved: URL builder, second-degree flag, Riyadh URN, presets, unquoted multi-word query support.

- `skills/linkedin-people-search/README.md`
  - Mapped to root `README.md` and `linkedin-people-url-filtering` package notes.
  - Preserved: deterministic filter order, reproducible URL templates, preset-driven execution.

## Session `ac6e02ff-6cf0-4f53-9a2e-cde2e7a48cd3`

- `linkedin_people_search_skill.md`
  - Mapped to `linkedin-boolean-query-refinement`, `linkedin-people-url-filtering`, and `search-state-verification-hygiene`.
  - Preserved: live-tested Boolean title variants, exact phrase quotes, NOT exclusions, quick filters before all-filters, top-10 checks, decision tree, common mistakes.

- `linkedin-people-search-skill/SKILL.md`
  - Mapped to `linkedin-boolean-query-refinement`.
  - Preserved: trigger, target definition, quick-filter order, Boolean templates, decision rules, pitfalls.

## Session `cf29e335-ac07-425b-baa7-aa35bfc94e95`

- `skills/linkedin-saudi-recent-hiring/SKILL.md`
  - Mapped to `linkedin-ksa-recent-hiring-posts` and `lead-scoring-dedup-pivots`.
  - Preserved: two-lane search, freshness sequence, adaptive logic, Google X-ray fallback, scoring, deduplication, pivots, output schema, URL template.

- `QUERY_PACK_TEMPLATE.md`
  - Mapped to `linkedin-ksa-recent-hiring-posts/QUERY_PACK_TEMPLATE.md`.
  - Preserved: Lane A, Lane B, Arabic variants, LinkedIn content URL, Google X-ray fallback, failure fallback sequence.

- `LIVE_TEST_REPORT.md`
  - Mapped to `linkedin-ksa-recent-hiring-posts/SKILL.md`.
  - Preserved: high-yield tested queries, strict role+email failure insight, Arabic-query strength, broad Google X-ray fallback, people/company pivot findings.

- `CHANGELOG.md`
  - Mapped to `linkedin-ksa-recent-hiring-posts/SKILL.md` and root packaging.
  - Preserved: v3 architecture, adaptive logic, dedup/scoring thresholds, reusable config/templates, winner query patterns.

- `README.md`
  - Mapped to root `README.md` and `linkedin-ksa-recent-hiring-posts`.
  - Preserved: package file roles, quick-start sequence, reusable variable-swap pattern.

- `manifest.json`
  - Mapped to `linkedin-ksa-recent-hiring-posts/manifest.json`.
  - Preserved: package metadata, inputs, outputs, language support, primary/fallback sources.

- `config.template.json`
  - Mapped to `linkedin-ksa-recent-hiring-posts/config.template.json`.
  - Preserved: roles, industries, geo scope, freshness, threshold, email priority, Google X-ray settings, negative terms.

- `templates/results_template.csv`
  - Mapped to `linkedin-ksa-recent-hiring-posts/templates/results_template.csv` and generalized in `lead-scoring-dedup-pivots`.
  - Preserved: accepted-post output fields.

- `templates/run_log_template.md`
  - Mapped to `linkedin-ksa-recent-hiring-posts/templates/run_log_template.md` and generalized in `search-state-verification-hygiene`.
  - Preserved: run metadata, query sequence, result summary, noise patterns, iteration changes.


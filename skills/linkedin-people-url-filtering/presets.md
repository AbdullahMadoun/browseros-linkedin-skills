# LinkedIn People Search Presets

## Preset: networking_riyadh

- Intent: warm introductions and networking.
- Query pattern: `<role> riyadh`.
- Filters: second-degree + Riyadh.
- Use when: outreach warmth matters more than exhaustive coverage.

## Preset: target_account_riyadh

- Intent: find relevant people inside specific companies.
- Query pattern: `<role> riyadh`.
- Filters: second-degree + Riyadh + current company when `--current-company-urn` is provided.
- Use when: the company target is known.
- Rule: add current company only after checking the base role/location result volume.

## Preset: broad_saudi_mapping

- Intent: map a market before narrowing.
- Query pattern: `<role> saudi arabia`.
- Filters: geography in the query first; add explicit `--geo-urn` only when the target location URN is known.
- Rule: avoid company filters in pass 1.

## Preset: strict_shortlist

- Intent: highly precise final list.
- Query pattern: `<role> <city>`.
- Filters: second-degree + explicit `--geo-urn` when known + optional `--current-company-urn` + All filters.
- Rule: use only after a broad pass proves the target pool exists.

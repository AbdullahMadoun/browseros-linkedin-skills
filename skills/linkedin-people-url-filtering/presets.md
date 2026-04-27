# LinkedIn People Search Presets

## Preset: networking_riyadh

- Intent: warm introductions and networking.
- Query pattern: `<role> riyadh`.
- Filters: second-degree + Riyadh.
- Use when: outreach warmth matters more than exhaustive coverage.

## Preset: target_account_riyadh

- Intent: find relevant people inside specific companies.
- Query pattern: `<role> riyadh`.
- Filters: second-degree + Riyadh + current company.
- Use when: the company target is known.
- Rule: add current company only after checking the base role/location result volume.

## Preset: broad_saudi_mapping

- Intent: map a market before narrowing.
- Query pattern: `<role> saudi arabia`.
- Filters: location first, then connection split in a second pass.
- Rule: avoid company filters in pass 1.

## Preset: strict_shortlist

- Intent: highly precise final list.
- Query pattern: `<role> <city>`.
- Filters: second-degree + location + optional company + All filters.
- Rule: use only after a broad pass proves the target pool exists.


---
name: linkedin-people-url-filtering
description: Build fast repeatable LinkedIn People searches using direct People URLs, clean query baselines, second-degree/location/company filters, reset hygiene, and URL-lock fallback.
metadata:
  display-name: LinkedIn People URL Filtering
  enabled: "true"
  version: "1.1"
---

# Skill: LinkedIn People URL Filtering

## Trigger

Use this skill when BrowserOS needs to find people on LinkedIn quickly, repeatedly, and with low click cost.

## Purpose

Produce a targeted LinkedIn People shortlist by entering the People vertical early, using clean URL baselines, applying high-signal filters in a deterministic order, and resetting stale state between runs.

## Inputs

- `QUERY`: role, title, company, domain, and/or geography terms.
- `LOCATION`: optional city/country target.
- `NETWORK`: optional connection degree, usually second-degree for outreach.
- `CURRENT_COMPANY`: optional target-account filter.
- `MODE`: `broad`, `networking`, `target-account`, or `strict-shortlist`.

## Outputs

- Final People-search URL.
- Ordered filter stack.
- Shortlist notes.
- Reliability notes for any UI or URL inconsistency.

## Golden rules

1. Enter `/search/results/people/` immediately.
2. Start with simple query text, usually `role + location`.
3. Apply filters light-to-heavy: connection degree -> location -> current company -> All filters.
4. Apply only one filter layer at a time.
5. Verify both visible result changes and URL/state changes after each layer.
6. Reset or reopen a clean URL before every new run.
7. If UI chips are inconsistent, switch to URL-lock mode.

## Stop Conditions

Stop refining and report when result quality is good enough for the requested
shortlist, two filter changes are neutral/worse, LinkedIn state cannot be
verified, or login/CAPTCHA/manual verification appears.

## Entry modes

### Mode A: UI-first

Use when the agent is already on LinkedIn.

1. Type the query in the global search bar.
2. Press Enter.
3. Switch to the `People` vertical immediately.
4. Continue with the filter sequence.

### Mode B: URL-first

Use when reproducibility matters or when a run must be repeated.

Open:

```text
https://www.linkedin.com/search/results/people/?keywords=<encoded_query>
```

This avoids the mixed `All` results detour.

## Verified URL signals

Use the URL as the source of truth when possible.

- Base People search: `?keywords=<encoded_query>`
- Second-degree network: `network=["S"]`
- Riyadh location: `geoUrn=["101336206"]`
- Current company: `currentCompany=["<company_urn>"]`
- `origin=GLOBAL_SEARCH_HEADER` is optional and not required for the clean baseline.

Example:

```text
https://www.linkedin.com/search/results/people/?keywords=project%20manager%20riyadh&network=%5B%22S%22%5D&geoUrn=%5B%22101336206%22%5D
```

## Filter sequence

1. `Connections`
   - Default to second-degree for warm outreach and mutual-rich profiles.
2. `Location`
   - Add city or country after the network layer.
3. `Current company`
   - Use only for target-account runs.
4. `All filters`
   - Use last, only after result volume and relevance are understood.

## Decision rules

- Need fast broad list: use URL-first + query + connection degree + location.
- Need networking list: prioritize second-degree and mutual-rich profiles.
- Need target-account list: add current company after connection and location.
- Need strict final shortlist: use All filters only after a broad pass succeeds.
- Results collapse unexpectedly: remove the last filter and inspect for stale state.
- Query is noisy: refine with the Boolean skill before adding many filters.

## Reset protocol

Before each new search cycle:

1. Click `Reset` if visible.
2. Or reopen a clean People URL with only intended parameters.
3. Confirm the URL contains only the intended `keywords`, `network`, `geoUrn`, and `currentCompany` parameters.
4. Confirm the page is still in People results, not All results.

## Error and drift handling

- No visible result change after a chip click: click once more, then enforce via URL if still unchanged.
- URL does not reflect the intended state: reopen a clean URL with explicit params.
- Old filters appear to persist: reset, then restart from the clean baseline.
- All filters are needed: apply them at the end and capture them in reliability notes because URL encoding may be harder to audit.

## Output schema

Capture this after each run:

```text
Intent:
Query:
Entry mode: UI-first / URL-first
Filters applied in order:
Final URL:
Observed quality notes:
Reliability notes:
Next iteration:
```

## Anti-patterns

- Staying in mixed `All` results when searching for people.
- Opening All filters before testing quick chips.
- Stacking many filters before checking result volume.
- Reusing a LinkedIn session without cleaning stale filters.
- Changing query and filters at the same time, then guessing what improved relevance.

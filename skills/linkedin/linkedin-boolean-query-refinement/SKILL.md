---
name: linkedin-boolean-query-refinement
description: Refine LinkedIn search quality with reusable Boolean role blocks, quoted title variants, NOT exclusions, one-variable iteration, and top-result relevance checks.
metadata:
  display-name: LinkedIn Boolean Query Refinement
  enabled: "true"
  version: "1.0"
---

# Skill: LinkedIn Boolean Query Refinement

## Trigger

Use this skill when LinkedIn results are broad, noisy, ambiguous, or missing relevant title variants.

## Purpose

Improve result quality without wasting clicks by building reusable Boolean query blocks, changing one variable per pass, and validating relevance against the top results before adding more filters.

## Inputs

- `ROLE_FAMILY`: target role and adjacent titles.
- `GEO_SCOPE`: city, country, or region.
- `COMPANY_SCOPE`: optional current or target company.
- `DOMAIN_CONTEXT`: optional industry or persona terms.
- `NOISE_TERMS`: terms that repeatedly produce irrelevant results.

## Outputs

- Reusable Boolean query block.
- Filter order used with the query.
- Top-10 relevance notes.
- Saved winning template.

## Core workflow

1. Define the target clearly.
   - Role/title family.
   - Location scope.
   - Company scope.
   - Seniority or must-have domain context.
2. Start in People results mode if using LinkedIn people search.
3. Build a title-family block using quoted exact titles and `OR`.
4. Add geography with `AND`.
5. Add domain or company context only when needed.
6. Add one `NOT` block to remove recurring noise.
7. Apply quick filters before full filters: connection degree -> location -> current company.
8. Change only one variable per pass.
9. Review the top 10 results before the next adjustment.
10. Save the winning query and filter stack as a template.

## Boolean patterns

### Title-variant block

```text
("Product Manager" OR "Senior Product Manager" OR "Group Product Manager" OR "Lead Product Manager")
```

### Title + geography

```text
("Product Manager" OR "Senior Product Manager") AND (Riyadh OR "Saudi Arabia")
```

### Noise exclusion

```text
("Product Manager" OR "Product Owner") NOT (Recruiter OR Consultant OR Agency)
```

### Company-targeted

```text
("Product Manager" OR "Product Lead") AND ("Company Name")
```

### Domain persona

```text
("Product Manager" OR "Growth Product Manager") AND (Fintech OR Payments OR "B2B SaaS")
```

## Decision rules

- Need speed and broad discovery: start with broad role keyword + People mode + light quick filters.
- Role names are ambiguous: add OR title variants before adding many UI filters.
- One exact title misses candidates: add local naming variants and seniority variants.
- Results are noisy: add NOT exclusions before opening All filters.
- Company target is known: use current company early, then refine with role Boolean.
- Alumni or network-led search: prioritize second-degree, mutual-rich profiles, school, or shared network angle.
- Need scale or segmentation: use save-search/list patterns when available, then segment by role, company, geography, or seniority.

## Iteration loop

For every pass:

1. Run the query.
2. Apply at most one new filter or one query edit.
3. Inspect top 10 results.
4. Label the change as `better`, `worse`, or `neutral`.
5. Keep only changes that improve relevance without destroying volume.

## Stop Conditions

Stop iterating when a query produces a useful top-result set, two consecutive
changes are neutral/worse, volume collapses, or the next improvement requires a
different workflow such as company mapping, people filtering, or comment mining.

## Practical default sequence

```text
("Product Manager" OR "Senior Product Manager" OR "Group Product Manager")
AND ("Saudi Arabia" OR Riyadh)
NOT (Recruiter OR Consultant OR Agency)
```

Then apply filters:

```text
second-degree -> location -> current company -> optional past company/school/industry
```

## Common pitfalls

- Over-constraining at the start with strict Boolean and many filters.
- Using only one title spelling.
- Adding company, location, seniority, and exclusions in one pass.
- Skipping NOT terms when irrelevant personas dominate.
- Opening All filters before testing quick chips.
- Failing to save the winning query/filter combination.

## Output schema

```text
Target:
Boolean query:
Filter stack:
Top-10 relevance:
Noise observed:
Change made this pass:
Change result: better / worse / neutral
Saved template:
```

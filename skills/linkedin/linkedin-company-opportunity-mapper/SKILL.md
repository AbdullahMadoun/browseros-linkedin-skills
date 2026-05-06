---
name: linkedin-company-opportunity-mapper
description: >-
  Analyze LinkedIn company pages for opportunity intelligence: jobs, posts,
  people, hiring signals, Saudi/location fit, best contacts, outreach angles,
  and pivots into recruiters, hiring managers, posts, and the Outreach sheet.
metadata:
  display-name: LinkedIn Company Opportunity Mapper
  enabled: "true"
  version: "1.2"
---

# LinkedIn Company Opportunity Mapper

Use this skill when BrowserOS needs to investigate a LinkedIn company page before
applying, reaching out, mapping a target account, or deciding whether a company
is worth pursuing. It is for free LinkedIn usage; do not depend on Premium-only
features.

For an actual company mapping run, load
`references/company-opportunity-details.md` for scoring rubrics, extraction
fields, output schema, Outreach sheet integration, and anti-patterns.

## Goal

Turn a LinkedIn company page into an action-ready opportunity map covering:

- what the company does
- jobs and hiring activity
- recent posts and opportunity signals
- people/contact routes
- recruiters, hiring managers, founders, managers, and team leads
- Saudi/KSA or target-location relevance
- outreach hooks and next actions

## Inputs

- `COMPANY_URL` or `COMPANY_NAME`
- `TARGET_ROLE`
- `GEO_SCOPE`, default Saudi Arabia/KSA when user context suggests it
- optional candidate profile notes
- `MODE`: `quick-scan`, `target-account`, `pre-application`, `outreach-map`, or
  `deep-brief`
- optional Outreach sheet tracking request

## Core Rules

1. Stay LinkedIn-first: Company page -> Jobs -> Posts -> People.
2. Use company-page evidence, not assumptions.
3. Treat marketing copy as weak evidence unless supported by jobs, posts,
   employees, or concrete initiatives.
4. Prefer contacts with current company/title evidence.
5. Do not message, connect, or add weak leads unless the user asks for that
   workflow.
6. Record uncertainty when LinkedIn hides data or visibility is incomplete.
7. Protect personal names, profile URLs, and contact routes in chat summaries
   unless the user asks for exact identifiers.

## Workflow

1. **Verify identity.** Open `COMPANY_URL` directly or search by name. Confirm
   visible company name, canonical URL, industry, size/location/website when
   visible, and disambiguation notes.
2. **Scan About.** Extract visible evidence about domain, locations, size,
   website/careers link, specialties, Saudi/KSA relevance, and target-role fit.
3. **Scan Jobs.** Collect relevant jobs, score fit, and mark application/contact
   priority. If no jobs are visible, say that LinkedIn shows no visible jobs; do
   not infer no hiring.
4. **Scan Posts.** Look for hiring, growth, projects, funding, Saudi expansion,
   partnerships, AI/data/product/engineering initiatives, events, and employee
   spotlights.
5. **Map People.** Search recruiters/talent, hiring managers, department heads,
   founders for startups, target-team employees, alumni/mutuals, and
   second-degree contacts.
6. **Verdict.** Assign `High`, `Medium`, `Low`, or `Ignore for now` from visible
   evidence.
7. **Next actions.** Recommend apply, connect/message, comment/engage, pivot
   search, or Outreach sheet tracking as appropriate.

## Fast Path

```text
company page content -> full jobs link if present -> posts signals -> people only for contact mapping
```

Use `get_page_content` and `get_page_links` before clicking tabs. If a company
page shows a jobs count/carousel, open the full jobs URL before judging hiring
coverage.

## Companion Skills

Use when relevant:

- `search-state-verification-hygiene` before repeated LinkedIn filtering or stale-state recovery.
- `linkedin-people-url-filtering` for People tab searches and current-title validation.
- `linkedin-boolean-query-refinement` when post or people queries are noisy.
- `lead-scoring-dedup-pivots` after collecting candidate people/posts.
- `linkedin-outreach-sheet-workflow` when the user wants tracking rows.
- `google-sheets-connector-reliability` for connector-first sheet updates.

## Stop Conditions

Stop and report when login/CAPTCHA/manual verification blocks progress, company
identity cannot be confidently disambiguated, the page has no useful visible
jobs/posts/people/pivots, or LinkedIn search/filter state stays stale after
three to four attempts.

---
name: research-opportunity-finder
description: >-
  Find credible in-person AI, CS, ML, data, software engineering, or computer
  vision research opportunities such as research assistant roles, visiting
  student programs, funded summer research, lab openings, and masters-adjacent
  routes. Verify eligibility, deadlines, funding, location, application path,
  and duplicate status before recommending next actions.
metadata:
  display-name: Research Opportunity Finder
  enabled: "true"
  version: "1.0"
---

# Research Opportunity Finder

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this to find serious research opportunities, not generic job listings. Prioritize credible in-person routes: university labs, official programs, funded summer research, research assistant roles, visiting student opportunities, and professor-posted openings.

## Search Scope

Include:

- AI, ML, computer vision, data science, software engineering, HCI, robotics, and applied CS labs
- undergraduate, final-year, recent graduate, visiting student, summer research, pre-master, MS/PhD-adjacent routes
- Saudi, GCC, UAE, Qatar, Europe, North America, and credible global programs when feasible

Exclude by default:

- already-applied programs recorded in memory
- online-only programs unless explicitly requested
- pay-to-participate programs without strong value
- vague training courses or bootcamps
- expired deadlines unless useful as recurring targets

## Source Quality

Prefer:

- official university pages
- professor/lab pages
- department announcements
- official application portals
- credible scholarship/funding pages
- original LinkedIn or email postings when visible

Use aggregators only as leads, then verify against primary sources.

## Fast Workflow

1. Start with official sources and known opportunity families.
2. Search broad enough to find programs, then verify each candidate on the
   primary source.
3. Extract eligibility, deadline, funding, location, and application route before
   spending time on fit narrative.
4. Check duplicate/prior-application memory before recommending outreach.
5. Rank only candidates with a clear next action.

## Safety Boundary

Do not apply, email, message, register, or submit interest forms unless the user
explicitly asks for that exact action. For discovery runs, stop at recommended
next actions and source links.

## Extraction Schema

For each candidate:

```text
Opportunity:
Institution/lab:
Location and mode:
Research area:
Eligibility:
Deadline:
Funding/compensation:
Application route:
Required documents:
Contact person:
Fit rationale:
Risks or blockers:
Source links:
Recommended next action:
```

## Duplicate And Memory Check

Before recommending outreach or application:

- check the user's long-term job/research memory when available
- mark duplicates, prior applications, prior outreach, and stale opportunities
- avoid re-contacting the same professor/lab without a reason

## Output Standard

Rank opportunities by fit, credibility, urgency, and actionability. Separate:

- apply now
- monitor
- professor outreach
- weak or rejected leads

For substantial searches, save a reusable markdown and structured JSON/CSV artifact.

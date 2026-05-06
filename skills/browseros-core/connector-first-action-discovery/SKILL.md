---
name: connector-first-action-discovery
description: >-
  Use BrowserOS connected-app actions before fragile browser UI automation for
  Gmail, Outlook, Google Sheets, Google Drive, GitHub, Slack, Notion, Linear,
  Jira, Vercel, Supabase, Cloudflare, Stripe, YouTube, and similar services.
  Discover available actions, execute minimal safe calls, and fall back to web
  UI only for proven connector gaps.
metadata:
  display-name: Connector-First Action Discovery
  enabled: "true"
  version: "1.0"
---

# Connector-First Action Discovery

## Purpose

Prefer structured connected-app actions over browser clicks when the task is about app data, records, mail, files, issues, deployments, sheets, or messages.

## Discovery Pattern

1. Identify candidate connected apps from the user request and current page.
2. Discover categories or actions for those apps.
3. If only categories are shown, inspect relevant category actions.
4. Get action details before execution.
5. Execute the smallest read-only action first when state is uncertain.
6. Use narrow output fields to avoid huge responses.
7. Verify write actions by reading back the changed record or visible state.

## Fast Path

For read-only or draftable app tasks:

```text
discover categories -> list actions -> get one action detail -> execute smallest safe read/draft -> verify
```

Do not open the web app merely to discover whether an action exists. Open the UI
only after a connector gap is proven or visual verification is required.

## Fallback Rule

Use web UI only when:

- the connector lacks the action
- the connector cannot attach local files
- visual formatting, settings, scheduling UI, or account-specific controls are required
- authentication requires a browser handoff
- the user specifically wants dashboard/browser verification

When falling back, record the connector gap so the next run does not rediscover it.

## Safety Boundaries

Pause before connector actions that:

- send email, chat, or social messages
- create, update, delete, merge, publish, deploy, invite, bill, refund, or change permissions
- modify production projects, domains, secrets, automation, or customer-facing content

Read-only lookup and draft creation may proceed when the user's intent is clear.

## Auth Handling

Do not ask for passwords or tokens. If a connector action fails due to authentication, use BrowserOS auth recovery guidance and continue from the failed action after auth is restored.

## Output Standard

Return:

```text
Connector/app used:
Action(s) used:
Read/write status:
Verification method:
Fallback needed:
Reusable connector gap:
```

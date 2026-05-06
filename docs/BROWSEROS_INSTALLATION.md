# BrowserOS Installation

This guide records the BrowserOS setup flow for installing this skill repo from the Assistant tab.

## 1. Open Settings

From the Assistant tab, click the settings icon and open BrowserOS AI provider settings.

## 2. Choose ChatGPT Plus/Pro

Use the `ChatGPT Plus/Pro` quick provider template and complete login. BrowserOS manages this provider through OAuth, so no API key is needed for that template.

![BrowserOS provider settings with ChatGPT Plus/Pro template](assets/browseros-provider-settings.png)

## 3. Optional Model Override

Dev tip: after the provider is added, click `Edit` and override the frontend model to `gpt-5.5` if it is available on your account.

Recommended visible settings from the tested flow:

- `Provider Type`: `ChatGPT Plus/Pro`
- `Reasoning Effort`: `High`
- `Reasoning Summary`: `Auto`
- `Model`: `gpt-5.5`
- `Supports Images`: checked
- `Temperature`: `0.2`

![BrowserOS edit provider model settings](assets/browseros-provider-edit-model.png)

The model dropdown is where the available frontend model overrides appear.

![BrowserOS model dropdown](assets/browseros-provider-model-dropdown.png)

## 4. Test Provider

Click `Test` on the provider card or inside the edit dialog. Continue only after the test succeeds.

If the test fails:

- confirm the provider is logged in
- confirm the selected model is available to the account
- try the default model before using a frontend override
- refresh BrowserOS settings and test again

## 5. Install The Skills From Assistant

Open the Assistant tab and send:

```text
Install this repo and add them as skills:
https://github.com/AbdullahMadoun/browseros-linkedin-skills

After installing, update persistent memory to know exactly how to utilize them.
```

If installing from a fork, replace the GitHub URL with the fork URL.

## 6. Verify Installation

Ask the Assistant to confirm:

```text
List the installed custom skills from browseros-linkedin-skills and summarize when each group should be used.
```

Expected result:

- BrowserOS core skills are available for routing, connector-first discovery, unknown-site learning, approved-answer handling, and live skill evolution.
- LinkedIn skills are available for search, outreach, messaging, and Easy Apply workflows.
- Job portal skills are available for external application forms, unknown ATS flows, verified document upload, and stop-before-submit behavior.
- Research opportunity skills are available for AI/CS opportunity discovery and professor/lab outreach preparation.
- Resume/application skills are available for fit and keyword review, tailoring, cover letters, draft review, hallucination audits, and interview prep.
- Gmail skills are available for connector-first mail operations and web fallback workflows.
- Outlook skills are available for connector-first drafting, local attachment, send, and scheduled send workflows.
- Obsidian skills are available for long-term BrowserOS memory plus local job-search keyword and lead intelligence vault maintenance.
- Google Sheets and search-lead reliability skills are available for state cleanup, deduplication, scoring, and sheet recovery.

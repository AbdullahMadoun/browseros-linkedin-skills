# Skill Improvement Workflow

Use this workflow when creating a new BrowserOS skill or improving an existing one.

The purpose of a skill is to save BrowserOS from rediscovering the same workflow every time. A good skill captures the reliable path through a task: which buttons to use, which paths are slow, which states prove success, which fields are risky, and where the workflow should stop for user confirmation.

## When To Create A Skill

Create or improve a skill when:

- the same browser workflow is likely to be repeated
- the task has fragile UI steps, hidden controls, confusing buttons, or multiple paths
- the task requires safety rules, such as before sending messages, submitting applications, uploading documents, or changing data
- the workflow benefits from known shortcuts, direct URLs, connector-first actions, or verification rules
- repeated manual exploration would waste time or create avoidable mistakes

Do not create a skill for one-off tasks that have no reusable path.

## Exploration Prompt

Use this prompt to teach BrowserOS a workflow:

```text
We will explore [workflow]. Try it out, try all buttons and clicks, learn everything about it to find an optimal method of usage and all features related to it. Try it extensively using all paths possible, all clicks, and all buttons.
```

Replace `[workflow]` with the specific task, for example:

- `LinkedIn Easy Apply with a tailored resume`
- `Outlook scheduled send with an attachment`
- `LinkedIn company page opportunity mapping`
- `Google Sheets connector recovery after partial writes`

## Exploration Rules

During exploration:

- start from the real page, connector, or file flow when possible
- try the normal path first, then alternative paths
- record labels, button text, menu names, modal states, and direct URLs
- identify which steps are reliable and which are flaky
- identify hidden controls such as file inputs or duplicated buttons
- note where the workflow must stop for user confirmation
- verify success from UI state, connector reads, or output artifacts
- avoid sending, submitting, deleting, or publishing unless the user explicitly approves that exact action

## Improvement Prompt

After the first exploration pass, ask:

```text
Any improvement areas or any paths that feel uncomfortable or slow to use? If applicable, do another pass of improvement.
```

Use the second pass to find:

- faster entry points
- direct URLs
- safer confirmation points
- clearer stop conditions
- better verification signals
- less fragile selectors or button paths
- opportunities to use connectors before browser UI
- ways to avoid duplicate work, stale state, or repeated retries

## Skill Creation Prompt

After exploration and improvement, ask:

```text
Add it to my skills. Make sure there is minimal overlap with existing ones and report to me any issues.
```

Before adding the skill:

1. Check existing skills for overlap.
2. Extend an existing skill if the new workflow is a narrow variant.
3. Create a new skill only when the workflow has a distinct trigger, safety model, or operating path.
4. Report any overlap, uncertainty, unsafe steps, or missing verification before writing the skill.

## What The Skill Should Capture

A useful skill should include:

- when to use it
- inputs needed before starting
- the fastest reliable workflow
- fallback paths
- safety rules
- confirmation points
- success indicators
- failure indicators
- recovery rules
- output expectations
- companion skills, if relevant

Keep the skill concise. It should teach the reusable workflow, not narrate the entire exploration history.

## Public-Repo Cleanup

Before publishing a skill:

- remove personal names, local paths, private filenames, account-specific examples, and local machine details
- replace private examples with generic placeholders
- avoid exposing email addresses, phone numbers, profile URLs, message snippets, or document names
- make skill names public and generic
- place the skill under the right `skills/<group>/` folder
- ensure `name` in front matter matches the skill folder name
- keep companion-skill references accurate
- update the README, skill catalog, and usage ideas

## Good Final Report To The User

When the skill is added, report:

- skill name and folder
- what workflow it captures
- what overlap was found and how it was handled
- any safety rules added
- any known gaps or paths that still need live testing
- whether docs and indexes were updated

Do not push until the user confirms the complete skill batch is ready.

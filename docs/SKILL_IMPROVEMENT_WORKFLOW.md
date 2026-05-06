# Skill Improvement Workflow

Use this workflow when creating a new BrowserOS skill or improving an existing one.

The purpose of a skill is to save BrowserOS from rediscovering the same workflow every time. A good skill captures the reliable path through a task: which buttons to use, which paths are slow, which states prove success, which fields are risky, and where the workflow should stop for user confirmation.

For live runs, use `browseros-skill-evolution-loop` as the end-of-run learning gate. It decides whether a new insight belongs in a run note, private memory, an existing skill patch, a new skill, or nowhere.

When a reusable insight should survive future sessions, route it through
`obsidian-long-term-memory-workflow`. Run notes are evidence; Obsidian is the
durable memory layer.

## When To Create A Skill

Create or improve a skill when:

- the same browser workflow is likely to be repeated
- the task has fragile UI steps, hidden controls, confusing buttons, or multiple paths
- the task requires safety rules, such as before sending messages, submitting applications, uploading documents, or changing data
- the workflow benefits from known shortcuts, direct URLs, connector-first actions, or verification rules
- repeated manual exploration would waste time or create avoidable mistakes
- a live run revealed a verified reusable insight, such as a faster URL, reliable label, connector gap, failure signal, success signal, or recovery path

Do not create a skill for one-off tasks that have no reusable path.

## Skill Hygiene Rules

Keep the skill set small and sharp:

- Prefer one canonical skill when two workflows share the same trigger, inputs, safety model, and output.
- Keep narrow site-mechanics skills separate when the UI path is fragile or safety-sensitive.
- Keep connector reliability skills short; they should define guardrails, not become full app manuals.
- Do not preserve old skill names as wrappers unless active routing would otherwise break.
- When collapsing skills, update catalog, usage chains, group indexes, and installed skills with prune enabled.
- Preserve performance by moving essential rules into the canonical skill before deleting overlap.

## Live Learning Loop

During real BrowserOS work:

1. For any new domain/site family or new workflow family, run a first-time exploration pass before full automation.
2. Capture insights as they happen: URLs, labels, hidden controls, validation errors, final-action boundaries, success signals, failure signals, connector gaps, and recovery paths.
3. At the end of the run, classify each insight:
   - `run_note`: useful but one-off or not yet verified
   - `private_memory`: short-lived personal paths, approved answers, real contacts, document names, or duplicate state that belongs in a private local store
   - `obsidian_memory`: durable preferences, workflow learning, duplicate state, research findings, or private skill insights that should survive future sessions
   - `site_registry`: public-safe domain/workflow learning that marks a site family as known
   - `existing_skill_patch`: verified, generic, and improves a current skill
   - `new_skill_candidate`: a distinct repeatable workflow
   - `do_not_store`: secrets, credentials, one-time codes, private message content, or speculation
4. Patch the repo source of truth first when a public skill should change.
5. Sync installed BrowserOS skills only after validation.

Do not patch public skills with account-specific observations, personal defaults, private filenames, real profile URLs, private messages, or unverified guesses. Save durable private learning in Obsidian instead.

For large known sites with many independent feature families, use a
site-specific feature-learning skill when available. For example, use
`linkedin-feature-learning-lab` to map a new LinkedIn branch, then promote the
verified branch insight into the narrowest existing LinkedIn skill.

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

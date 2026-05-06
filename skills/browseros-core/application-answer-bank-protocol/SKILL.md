---
name: application-answer-bank-protocol
description: >-
  Use a private approved-answer bank for job applications, outreach, forms, and
  profile workflows without storing personal answers in public skills. Handles
  known defaults, ask-each-time fields, never-guess fields, file choices, and
  confirmation boundaries for sensitive application information.
metadata:
  display-name: Application Answer Bank Protocol
  enabled: "true"
  version: "1.0"
---

# Application Answer Bank Protocol

## Long-Term Memory

When durable memory is needed, use `obsidian-long-term-memory-workflow` to save it in an Obsidian vault. Keep chat and run notes transient unless they are linked from Obsidian.

## Purpose

Use this whenever a workflow needs personal, application, or outreach answers. Public skills must not contain private defaults.

Default private path: `~/.browseros/private/application-answer-bank.json`.

If the private file is unavailable, ask only for the exact missing fields encountered.

When an answer, preference, or document-choice rule needs durable memory, use
`obsidian-long-term-memory-workflow` to store a pointer or policy note. Keep raw
sensitive values in the private answer bank unless the user explicitly asks to
store them in an Obsidian vault.

## Answer Classes

Every reusable answer should be treated as one of:

- `approved_default`: safe to use when the field meaning matches exactly.
- `ask_each_time`: prompt the user every time.
- `never_guess`: stop unless the user explicitly provides the answer for this workflow.
- `requires_confirmation`: prepare with the answer but confirm before final action.

## Never Guess

Never infer or invent:

- work authorization
- sponsorship or visa status
- salary or compensation
- notice period
- start date or availability
- relocation willingness
- years of experience
- language proficiency
- degree status
- certifications
- phone, address, ID numbers, or sensitive contact details
- file path, CV version, transcript, portfolio, or cover-letter document

Use approved defaults only when the field wording and context match the stored answer.

## Field Matching

Before using a stored answer:

1. Read the exact field label and surrounding help text.
2. Match against the answer-bank key and allowed contexts.
3. Check for required format such as number, dropdown option, yes/no, date, or free text.
4. If the portal wording changes the meaning, ask the user.

## File Choices

For document uploads:

- verify the exact local file exists
- verify the intended role/company/context
- verify visible uploaded filename after upload
- stop if the portal shows a different file or only a generic document card

## Output Standard

When stopping for missing data, ask compactly:

```text
I need these exact fields before continuing:
- Field label:
- Portal options, if any:
- Why it cannot be inferred:
```

Do not expose full private answers in chat unless the user asks for the exact content.

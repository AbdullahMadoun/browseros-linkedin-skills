# LinkedIn Easy Apply Details

Load this reference for real Easy Apply preparation, upload troubleshooting,
screening questions, logging, or resume cleanup.

Sections: URL patterns, flow detection, resume upload, screening questions,
validation/drafts, resume settings cleanup, logging, and learn-later cases.

## URL And Job ID Patterns

Easy Apply search:

```text
https://www.linkedin.com/jobs/search/?keywords=ROLE&location=LOCATION&f_AL=true&sortBy=DD
```

Direct job:

```text
https://www.linkedin.com/jobs/view/{jobId}/
```

Direct apply modal:

```text
https://www.linkedin.com/jobs/view/{jobId}/apply/?openSDUIApplyFlow=true
```

Extract `{jobId}` from the numeric segment in `/jobs/view/{jobId}/`.

If the direct modal URL loads the job detail page without opening a modal, try
the visible Easy Apply button once, then inspect the enhanced snapshot and DOM
for `dialog`, `[role=dialog]`, and `input[type=file]`. If no modal appears,
classify the state as `easy_apply_modal_unavailable` instead of repeatedly
clicking. Inspect the job description for an alternate visible contact route or
apply URL, record it, and ask before switching to an external/direct-contact
application workflow.

LinkedIn Easy Apply modals may require a visible foreground tab. If background
tabs or direct modal URLs do nothing, open the job/apply URL in a foreground tab
and retry once before declaring the modal unavailable.

## Flow Detection

One-step applications usually include contact info, email dropdown, phone country
code, phone number, resume selector/upload, optional follow-company checkbox,
and final `Submit application`. Verify everything, uncheck follow-company if the
user prefers, then stop before submit.

Multi-step applications commonly move through contact info, resume
upload/selection, screening questions, review application, and submit. Continue
only when values are known. Pause for missing required answers.

Observed modal signals:

- container role `dialog` with class such as `jobs-easy-apply-modal`
- heading `Apply to <Company>`
- progress region such as `25%`
- `Back` / `Next` / `Continue to next step`
- provider line such as `Application powered by <ATS>`

Observed screening types:

- Yes/No radios
- Yes/No dropdowns
- textboxes for salary or short answers
- numeric fields for years of experience

Numeric-only fields need plain digits such as `0`, `1`, `2`, `3`, not text like
`1 year`.

## Resume Upload

LinkedIn may keep many old resumes; selector clutter slows work and increases
wrong-file risk. Newest uploaded resume usually appears near the top and may
auto-select.

Rules:

- Keep tailored LinkedIn resume PDFs under 2 MB.
- Use distinctive names such as `ApplicantName_ROLE_COMPANY.pdf`.
- Avoid vague names such as `Resume.pdf`, `final.pdf`, or `Resume_Vague.pdf`.

Normal upload:

1. Locate `Upload resume`.
2. Click it or locate the file input.
3. Upload the tailored local PDF.
4. Verify the new filename appears and is selected.
5. Continue only after verifying the correct resume.

Fallback:

- Search DOM for `input[type=file]`.
- Use `upload_file` directly if BrowserOS can upload to the hidden input.
- If no input is exposed, click `Upload resume`, re-snapshot, and search again.
- Prefer document-capable inputs and avoid image-only inputs.
- Do not use JavaScript to modify application answers or submission state.

If upload fails, check file size, path existence, retry once, then report the
exact blocker.

LinkedIn may show saved resume cards with:

- selected/deselected radio controls
- download buttons
- visible filename, size, and last-used date
- hidden `input[type=file]` behind the Upload resume button
- `Show more resumes` when old files are stored

Verify the selected resume by filename before continuing. If old resumes create
ambiguity, stop or ask to clean saved resumes.

## Screening Questions

Safe sources:

- user-provided answer bank
- private application answer bank
- existing known facts from memory/resume when directly supported
- obvious non-sensitive prefilled values

Common fields:

- work authorization
- sponsorship requirement
- current city/country
- willingness to relocate
- notice period
- salary expectation
- years of experience by skill/tool
- degree status
- Arabic and English proficiency
- remote/on-site/hybrid preference
- phone country code

If a required field is unknown, stop and ask a compact question batch:

```text
I am at screening questions for [Company] / [Role]. I need these values before continuing:
1. Notice period:
2. Salary expectation:
3. Years of [tool/skill] experience:
```

Prefer exact visible dropdown/radio options. If ambiguous, pause. For Saudi phone
country code, verify `+966` if relevant. Do not change phone or email unless the
user asks.

## Validation And Draft Handling

If LinkedIn blocks continuation:

1. Identify the highlighted required field.
2. Fill it if known.
3. Ask the user if unknown.
4. Retry once after correction.

If the modal needs closing, click `X`, `Dismiss`, or the close control. Choose
`Discard` for stale/practice drafts and `Save` only if the user wants to resume
later.

LinkedIn can show a `Save this application?` gate before opening or while closing
an Easy Apply flow. For tests or stale drafts, dismiss or discard only when that
matches the user's intent. Capture the job URL before discarding because the page
may navigate away from the job after cleanup.

## Resume Settings Cleanup

LinkedIn may store old resumes and application answers.

If the user asks to clean old resumes:

1. Open LinkedIn Jobs application settings or resume/application-data settings.
2. Look for `Resumes and application data`.
3. Review saved resumes by filename and date.
4. Do not delete or disable anything unless the user explicitly approves the
   exact item or setting.
5. Keep newest role/company-specific resumes; remove stale generic files only
   after confirmation.

The exact manager URL may change; prefer navigating through LinkedIn UI unless a
stable URL has been verified in the current session.

## Logging

For batches, log:

```text
Date
Job title
Company
Job URL
Apply URL
resume filename
Flow type: one-step / multi-step
Status: prepared / submitted / blocked / skipped / already applied
Blocker or notes
```

Machine statuses:

- `ready_to_submit`
- `submitted_with_confirmation`
- `needs_user_answers`
- `not_easy_apply`
- `easy_apply_modal_unavailable`
- `alternate_contact_route_found`
- `already_applied`
- `upload_failed`
- `discarded_draft`
- `blocked`

## Learn Later

When encountered naturally, update the skill with:

- stable resume deletion/cleanup path
- stable resume manager URL
- complex screening-section handling
- external redirected application patterns
- inaccessible upload-input cases
- reliable detection of uploaded resume selection across modal variants

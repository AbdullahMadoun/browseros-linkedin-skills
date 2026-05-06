# Greenhouse ATS Notes

Load for Greenhouse-hosted job boards and job application forms.

## Entry Points

Greenhouse boards may appear under either:

- `https://boards.greenhouse.io/<company>`
- `https://job-boards.greenhouse.io/<company>/jobs/<job_id>`

The board page can expose job links with full text labels. `get_page_links` is a
fast way to extract stable job-detail URLs when normal clicking does not
navigate.

## Board Behavior

Common controls:

- company logo / back to jobs
- `Create alert`
- search textbox
- department combobox
- office combobox
- paginated job list

Pagination may expose many pages. For targeted automation, use search/filter
first and collect visible job links before moving pages.

## Application Form Mechanics

Greenhouse job detail pages can expose the whole application form on the same
page below the description.

Common fields:

- first name, last name, email
- country combobox and phone input with phone-country dialog
- resume attach button backed by a visually hidden `input[type=file]`
- Dropbox / Google Drive / enter manually alternatives
- website, LinkedIn profile, additional information
- role-specific required text questions
- required sponsorship, relocation, prior-interview, office, AI-policy, or
  availability comboboxes
- optional demographic, veteran, and disability sections
- final `Submit application`

Greenhouse may use React-style combobox inputs plus hidden required inputs.
Interact through visible comboboxes and exact visible options; do not write
directly into hidden required inputs.

## Uploads

Resume attach often has:

- visible `Attach` button
- hidden file input such as `input[type=file]`
- accepted extensions: `.pdf`, `.doc`, `.docx`, `.txt`, `.rtf`
- cloud sources such as Dropbox and Google Drive
- manual resume entry

Upload only the user-approved file and verify the visible filename afterward.

## Safety And Validation

- Do not rely on `Submit application` being disabled. It can be enabled while
  required fields are empty.
- Stop before final submit unless the user explicitly confirms that exact
  application.
- If testing validation, use a disposable/test form only. Do not click final
  submit on a real employer application just to discover errors.
- Optional demographic/equal-opportunity questions should be skipped or answered
  only from an approved user preference.

## Workflow Map Template

```text
Site family: Greenhouse
Board URL:
Job URL:
Listing controls:
Required fields:
Upload controls:
Comboboxes:
Final-action boundary: Submit application
Success signal:
Failure/validation signal:
Known unknowns:
```

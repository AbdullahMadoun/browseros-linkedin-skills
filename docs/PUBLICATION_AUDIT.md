# Publication Audit

Run this checklist before publishing updates to this repository.

## Scope Check

- Every custom skill has exactly one leaf folder under `skills/<group>/`.
- Every skill folder has a `SKILL.md`.
- BrowserOS built-in skills are not vendored unless intentionally documented.
- New workflows have minimal overlap with existing skills.
- Existing skills were extended instead of duplicated when the workflow was only a variant.

## Metadata Check

- `SKILL.md` has valid YAML front matter.
- `name` matches the folder name exactly.
- `description` explains when the skill should trigger.
- Public display names are readable and not account-specific.
- Companion skill references point to existing skill names.

## Privacy Check

Search for and remove:

- personal names
- local filesystem paths
- private filenames
- usernames, handles, and account-specific URLs
- phone numbers and personal email addresses
- message snippets and private thread content
- application-material details that identify a specific person

Use generic examples such as:

- `ApplicantName_ROLE_COMPANY.pdf`
- `<local-browseros-skills-dir>`
- `<company>`
- `<role>`
- `<recipient>`

## Safety Check

Skills should require explicit confirmation before:

- submitting applications
- sending emails or LinkedIn messages
- uploading sensitive documents
- scheduling emails
- deleting drafts or records
- posting public comments
- overwriting user data

Each workflow should include a success signal and at least one recovery path for common failure states.

## Documentation Check

Update these files when skills are added, removed, or renamed:

- `README.md`
- `docs/BROWSEROS_INSTALLATION.md` if setup, provider, or install-prompt behavior changes
- `skills/README.md`
- `docs/SKILL_CATALOG.md`
- `docs/USAGE_IDEAS.md`
- `CONTRIBUTING.md` if contribution options or folder placement change
- `docs/SKILL_IMPROVEMENT_WORKFLOW.md` if the improvement process changes

Keep public docs focused on usage. Do not include old import history, private source paths, package names, or local-session notes.

## Suggested Commands

Run from the repository root:

```bash
find skills -type f -name SKILL.md | sort
```

```bash
ruby -ryaml -e 'Dir["skills/**/SKILL.md"].sort.each do |f| text=File.read(f); parts=text.split(/^---\s*$/); abort "bad frontmatter: #{f}" if parts.length < 3; y=YAML.safe_load(parts[1], permitted_classes: [], aliases: false); abort "missing name: #{f}" if y["name"].to_s.strip.empty?; abort "missing description: #{f}" if y["description"].to_s.strip.empty?; folder=File.basename(File.dirname(f)); abort "name/folder mismatch: #{f} name=#{y["name"]}" if y["name"] != folder; end; puts "frontmatter ok"'
```

```bash
rg -n -i 'PERSONAL_NAME|PUBLIC_HANDLE|PRIVATE_PROJECT|LOCAL_USER_PATH|WINDOWS_USER_PATH|OLD_PRIVATE_SKILL_NAME|PRIVATE_REPO_NAME' README.md docs skills scripts
```

```bash
git diff --check
```

Only publish after these checks are clean or any remaining findings are intentionally documented.

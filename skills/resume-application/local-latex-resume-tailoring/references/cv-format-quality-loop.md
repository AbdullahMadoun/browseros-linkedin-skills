# CV Format Quality Loop

Load this reference when a resume run needs format repair, final readiness
review, or repeated improvement.

The loop uses `scripts/cv_format_quality_check.rb` as an executable guardrail.
It does not replace judgment; it catches the common failures that make a CV look
worse while still "compiling".

## Five-Pass Loop

1. **Compile and structure pass.** Confirm the `.tex` exists, has document
   boundaries, has expected sections, and compiles when a local compiler exists.
2. **Density pass.** Compare approximate plain-text word count with the baseline
   resume. Investigate anything below 85% of the baseline unless the user asked
   for a lean version.
3. **Bolding pass.** Preserve retained bold anchors from the baseline and keep
   selective emphasis balanced. Do not flatten all bolding or bold whole lines.
4. **Section pass.** Check that summary, education, experience, projects, and
   skills still contain useful content. A present-but-empty section is a failure.
   Standard `\section`, `\cvsection`, `\resumeSection`, and `\sectionTitle`
   headings are recognized so preserved templates do not need to be flattened.
5. **Final artifact pass.** Verify page count, output PDF, placeholders, obvious
   escaping hazards, and saved reports. If `pdfinfo` is unavailable, record the
   warning and use the compile report or a manual PDF page check.

Run the checker after each material edit:

```text
ruby scripts/cv_format_quality_check.rb --tex <candidate.tex> --baseline <baseline.tex> --pdf <candidate.pdf> --out <quality_report.json>
```

Omit `--pdf` only when compilation is blocked; then record the compiler blocker
in the compile report.

## Checker Result Policy

- `pass: true`: The format gate did not find a blocking issue. Still review
  content truth and role fit.
- `issues`: Fix before sending or submitting.
- `warnings`: Review manually; warnings may be acceptable when the user changed
  the page target or template.
- `metrics`: Use word count, bold phrase count, retained bold ratio, page count
  when available, and section count to compare iterations.

## What To Fix First

Fix in this order:

1. missing PDF or page count mismatch
2. missing document boundaries or broken structure
3. placeholders and unsupported draft markers
4. empty sections
5. severe density loss
6. lost retained bold anchors
7. suspicious unescaped characters

Do not solve page pressure by deleting strong evidence first. Tighten weak
awards, redundant skills, repeated words, and spacing before cutting relevant
experience or projects.

## Self-Test

Use the built-in self-test when changing the checker or this skill:

```text
ruby scripts/cv_format_quality_check.rb --self-test <output-dir>
```

The self-test writes five fixture iterations and a Markdown summary. The final
fixture should pass while earlier fixtures demonstrate the gate catching real
formatting failures.

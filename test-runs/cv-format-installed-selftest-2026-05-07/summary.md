# CV Format Quality Self-Test

| Run | Fixture | Pass | Issues | Warnings | Word Count | Bold Anchors |
|---|---|---|---|---|---:|---:|
| 1 | run1_raw_placeholders.tex | false | empty_or_too_thin_sections: summary, education, experience, projects, skills; placeholder_markers_present: TODO, <target role>; density_below_baseline: 0.248 < 0.85 | low_bold_anchor_count: 0 < 3; pdf_not_checked | 29 | 0 |
| 2 | run2_structure_fixed_thin.tex | false | empty_or_too_thin_sections: summary, projects, skills; density_below_baseline: 0.419 < 0.85; retained_bold_anchors_lost: 0.0 < 0.8 | low_bold_anchor_count: 0 < 3; pdf_not_checked | 49 | 0 |
| 3 | run3_density_fixed_bold_lost.tex | false | retained_bold_anchors_lost: 0.0 < 0.8 | low_bold_anchor_count: 0 < 3; pdf_not_checked | 116 | 0 |
| 4 | run4_bold_fixed_escape_warning.tex | true |  | suspicious_unescaped_ampersand_lines: 16; pdf_not_checked | 122 | 8 |
| 5 | run5_final_ready.tex | true |  | pdf_not_checked | 117 | 8 |

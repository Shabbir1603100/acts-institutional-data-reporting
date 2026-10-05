# ACTS Institutional Data Reporting — Portfolio Reconstruction

A privacy-safe portfolio reconstruction of a longitudinal institutional reporting workflow for admissions, enrollment, financial aid, academic outcomes, and degree completion.

> **Portfolio notice:** This repository uses generalized schema names, synthetic data, and reconstructed SQL patterns. It contains no student records, Banner IDs, person identifiers, names, institutional extracts, credentials, or original submission workbooks.

## Project Summary

The project demonstrates how multi-source higher-education data can be transformed into submission-ready reporting datasets using Oracle SQL-style workflows. The original reporting work covered multiple academic years and separate undergraduate/graduate admissions and completer populations.

### Core workflow

1. Define the reporting period and cohort.
2. Build applicant/admissions populations.
3. Link enrollment snapshots.
4. Integrate demographic, test-score, financial-aid, GPA, and program attributes.
5. Apply reporting-code mappings and applicability rules.
6. Deduplicate to the required reporting grain.
7. Validate output before submission.

## Technologies

- Oracle SQL
- IBM Cognos
- Banner/ODS-style higher-education data
- Excel
- Window functions and CTE-based ETL
- Data validation and longitudinal cohort construction

## Repository Structure

```text
acts-institutional-data-reporting/
├── README.md
├── .gitignore
├── sql/
│   ├── 01_undergraduate_admissions.sql
│   ├── 02_undergraduate_completers.sql
│   ├── 03_graduate_admissions.sql
│   └── 04_graduate_completers.sql
├── data/
│   └── synthetic/
│       ├── undergraduate_admissions_sample.csv
│       └── completers_sample.csv
└── docs/
    ├── architecture.md
    ├── data_dictionary.md
    ├── methodology.md
    ├── validation_checklist.md
    └── privacy_and_sanitization.md
```

## Demonstrated Skills

- Multi-table SQL integration
- Cohort definition and census/snapshot logic
- CTE-based query design
- `ROW_NUMBER()`-based deduplication
- Conditional reporting logic with `CASE`
- Academic-year and term-based transformations
- Financial-aid aggregation
- Test-score and GPA transformations
- Degree-completion cohort construction
- Privacy-aware reporting and validation

## Important

The SQL in this repository is intentionally generalized. Names such as `admissions`, `student_enrollment`, `financial_aid`, `test_scores`, and `degree_completions` are portfolio-safe abstractions rather than production institutional object names.

No original institutional SQL, student-level output, or ACTS submission workbook is included.

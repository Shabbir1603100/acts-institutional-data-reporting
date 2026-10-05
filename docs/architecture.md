# Architecture

## Logical data flow

```text
Admissions -----------+
Student Enrollment ---+
Test Scores ----------+--> Cohort Integration --> Reporting Rules --> Deduplication --> Validation --> Final Dataset
Financial Aid --------+
Need Analysis --------+
Course Records -------+
Degree Completions ---+
```

The portfolio version separates source extraction from reporting logic. Each source is represented with a generic table name so the repository demonstrates the transformation design without disclosing production schema names.

## Reporting populations

The project models four major outputs:

- Undergraduate admissions
- Undergraduate completers
- Graduate admissions
- Graduate completers

Admissions workflows combine applicant status with enrollment and student attributes. Completer workflows select degree recipients inside an academic-year date window and reduce multiple degree records to the required student-level reporting grain.

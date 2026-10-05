# Methodology

## 1. Cohort parameters
A parameter CTE centralizes the academic year, fall/spring/summer terms, and reporting dates.

## 2. Admissions population
Applicant records are filtered to the target level and population. A reporting admission indicator is derived from source decision codes.

## 3. Enrollment linkage
Fall enrollment determines whether an admitted applicant enrolled and whether the student was full-time. Student attributes are taken from a consistent reporting snapshot.

## 4. Supporting attributes
Separate CTEs prepare test scores, high-school GPA, family-income information, financial-aid measures, course-taking indicators, and program information.

## 5. Completer population
Degree records are restricted to the reporting-year conferral window and target credential level. Window functions select one reporting record per student where required.

## 6. Reporting transformations
`CASE` expressions translate operational source values into reporting codes and distinguish valid values, unknown values, and not-applicable values.

## 7. Deduplication
`ROW_NUMBER()` is used with deterministic ordering so each reporting entity has one retained row at the required grain.

## 8. Validation
Validation checks compare row counts, duplicate counts, code domains, nulls, ranges, cohort dates, and cross-field dependencies before final export.

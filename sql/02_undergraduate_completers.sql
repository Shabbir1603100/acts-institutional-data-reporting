/*
Portfolio reconstruction: Undergraduate Completers
*/
WITH params AS (
    SELECT DATE '2024-07-01' AS start_date,
           DATE '2025-06-30' AS end_date
    FROM dual
),
ranked AS (
    SELECT
        d.student_key,
        d.race_eth,
        d.sex,
        d.cumulative_gpa,
        d.credential_level,
        d.conferral_date,
        ROW_NUMBER() OVER (
            PARTITION BY d.student_key
            ORDER BY d.conferral_date DESC
        ) AS rn
    FROM degree_completions d
    CROSS JOIN params p
    WHERE d.conferral_date BETWEEN p.start_date AND p.end_date
      AND d.awarded_ind = 'Y'
      AND d.credential_level = 'BACHELOR'
)
SELECT student_key, race_eth, sex,
       CASE WHEN cumulative_gpa BETWEEN 0 AND 4 THEN cumulative_gpa ELSE -1 END AS cumulative_gpa,
       credential_level
FROM ranked
WHERE rn = 1;

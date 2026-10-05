/*
Portfolio reconstruction: Undergraduate Admissions
All source names and records are synthetic/generalized.
*/
WITH params AS (
    SELECT
        'FALL_TERM'   AS fall_term,
        'SPRING_TERM' AS spring_term
    FROM dual
),
admissions_one AS (
    SELECT *
    FROM (
        SELECT
            a.student_key,
            a.race_eth,
            a.sex,
            a.admission_decision,
            a.admission_process,
            ROW_NUMBER() OVER (
                PARTITION BY a.student_key
                ORDER BY a.decision_priority DESC, a.updated_at DESC
            ) AS rn
        FROM admissions a
    )
    WHERE rn = 1
),
fall_enrollment AS (
    SELECT
        e.student_key,
        MAX(CASE WHEN e.enrolled_ind = 'Y' THEN 1 ELSE 0 END) AS enrolled,
        MAX(CASE WHEN e.time_status = 'FT' THEN 1 ELSE 0 END) AS full_time,
        MAX(CASE WHEN e.credential_level = 'BACHELOR' THEN 1 ELSE 0 END) AS bachelor_seeking
    FROM student_enrollment e
    CROSS JOIN params p
    WHERE e.term_code = p.fall_term
    GROUP BY e.student_key
),
scores AS (
    SELECT
        t.student_key,
        MAX(t.sat_math) AS sat_math,
        MAX(t.sat_reading) AS sat_reading,
        MAX(t.act_math) AS act_math,
        MAX(t.act_english) AS act_english,
        MAX(t.act_composite) AS act_composite
    FROM test_scores t
    GROUP BY t.student_key
)
SELECT
    a.student_key,
    a.race_eth,
    a.sex,
    CASE WHEN a.admission_decision = 'ADMIT' THEN 1 ELSE 0 END AS admission_status,
    a.admission_process,
    NVL(e.enrolled, 0) AS enrollment_status,
    CASE WHEN NVL(e.enrolled,0)=1 THEN NVL(e.full_time,0) ELSE -3 END AS full_time,
    CASE WHEN NVL(e.enrolled,0)=1 AND NVL(e.full_time,0)=1
         THEN NVL(e.bachelor_seeking,0) ELSE -3 END AS bachelor_seeking,
    NVL(s.sat_math, -1) AS sat_math,
    NVL(s.sat_reading, -1) AS sat_reading,
    CASE WHEN s.sat_math IS NOT NULL AND s.sat_reading IS NOT NULL
         THEN s.sat_math + s.sat_reading ELSE -1 END AS sat_total,
    NVL(s.act_math, -1) AS act_math,
    NVL(s.act_english, -1) AS act_english,
    NVL(s.act_composite, -1) AS act_composite
FROM admissions_one a
LEFT JOIN fall_enrollment e ON e.student_key = a.student_key
LEFT JOIN scores s ON s.student_key = a.student_key;

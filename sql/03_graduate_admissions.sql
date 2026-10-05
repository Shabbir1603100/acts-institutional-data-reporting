/*
Portfolio reconstruction: Graduate Admissions
*/
WITH admissions_one AS (
    SELECT *
    FROM (
        SELECT
            a.student_key,
            a.race_eth,
            a.sex,
            a.admission_decision,
            a.credential_level,
            a.cip_code,
            ROW_NUMBER() OVER (
                PARTITION BY a.student_key
                ORDER BY a.decision_priority DESC, a.updated_at DESC
            ) AS rn
        FROM graduate_admissions a
    )
    WHERE rn = 1
),
enrollment AS (
    SELECT
        student_key,
        MAX(CASE WHEN enrolled_ind='Y' THEN 1 ELSE 0 END) AS enrolled,
        MAX(CASE WHEN time_status='FT' THEN 1 ELSE 0 END) AS full_time
    FROM graduate_enrollment
    GROUP BY student_key
)
SELECT
    a.student_key,
    a.race_eth,
    a.sex,
    CASE WHEN a.admission_decision='ADMIT' THEN 1 ELSE 0 END AS admission_status,
    NVL(e.enrolled,0) AS enrollment_status,
    CASE WHEN NVL(e.enrolled,0)=1 THEN NVL(e.full_time,0) ELSE -3 END AS full_time,
    a.credential_level,
    a.cip_code
FROM admissions_one a
LEFT JOIN enrollment e ON e.student_key=a.student_key;

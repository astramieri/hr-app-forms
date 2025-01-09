CREATE OR REPLACE VIEW job_details_view AS
    SELECT
        j.job_id,
        j.job_title,
        c.cnt_employees AS current_employees,
        p.cnt_employees AS past_employees,
        c.min_salary,
        c.avg_salary,
        c.max_salary
    FROM
        jobs j
        OUTER APPLY (
            SELECT
                COUNT(DISTINCT e.employee_id) AS cnt_employees,
                MIN(e.salary)                 AS min_salary,
                MAX(e.salary)                 AS max_salary,
                AVG(e.salary)                 AS avg_salary
            FROM
                employees e
            WHERE
                e.job_id = j.job_id
        )    c
        OUTER APPLY (
            SELECT
                COUNT(DISTINCT h.employee_id) AS cnt_employees
            FROM
                job_history h
            WHERE
                h.job_id = j.job_id
        )    p
    ORDER BY
        j.job_title ASC;
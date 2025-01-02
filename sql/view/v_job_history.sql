CREATE OR REPLACE VIEW v_job_history AS
    SELECT
        h.employee_id,
        j.job_title,
        h.start_date,
        h.end_date,
        d.department_id,
        d.department_name
    FROM
             job_history h
        JOIN jobs        j ON j.job_id = h.job_id
        JOIN departments d ON d.department_id = h.department_id;
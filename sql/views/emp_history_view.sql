CREATE OR REPLACE VIEW emp_history_view AS
    SELECT
        h.employee_id,
        j.job_title,
        d.department_name,
        h.start_date,
        h.end_date
    FROM
             job_history h
        JOIN departments d ON d.department_id = h.department_id
        JOIN jobs        j ON j.job_id = h.job_id;
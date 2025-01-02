CREATE OR REPLACE VIEW v_employees AS
    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        e.email,
        e.phone_number,
        e.hire_date,
        e.salary,
        e.commission_pct,
        j.job_id,
        j.job_title,
        d.department_id,
        d.department_name,
        e.manager_id
    FROM
             employees e
        JOIN jobs        j ON e.job_id = j.job_id
        JOIN departments d ON e.department_id = d.department_id;
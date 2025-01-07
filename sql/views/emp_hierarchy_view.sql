CREATE OR REPLACE VIEW emp_hierarchy_view AS
    SELECT
        e.first_name
        || ' '
        || e.last_name
        || ' ('
        || j.job_title
        || ')'       AS employee_name,
        e.employee_id,
        e.manager_id,
        j.job_title,
        level        AS hierarchy_level,
        'fa fa-user' AS icon
    FROM
             employees e
        JOIN jobs j ON e.job_id = j.job_id
    START WITH
        e.manager_id IS NULL
    CONNECT BY
        PRIOR e.employee_id = e.manager_id
    ORDER SIBLINGS BY
        e.last_name ASC
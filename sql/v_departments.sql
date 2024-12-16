CREATE OR REPLACE VIEW v_departments AS
    SELECT
        d.department_id,
        d.department_name,
        e.employee_id AS manager_id,
        e.first_name  AS manager_first_name,
        e.last_name   AS manager_last_name,
        l.location_id,
        l.street_address,
        l.postal_code,
        l.city,
        l.state_province,
        c.country_id,
        c.country_name,
        r.region_id,
        r.region_name
    FROM
             departments d
        JOIN employees e ON e.employee_id = d.manager_id
        JOIN locations l ON l.location_id = d.location_id
        JOIN countries c ON c.country_id = l.country_id
        JOIN regions   r ON r.region_id = c.region_id;
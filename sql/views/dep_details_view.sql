CREATE OR REPLACE VIEW dep_details_view AS
    SELECT
        d.department_id,
        d.department_name,
        l.street_address,
        l.city,
        l.state_province,
        c.country_name,
        r.region_name
    FROM
             departments d
        JOIN locations l ON l.location_id = d.location_id
        JOIN countries c ON c.country_id = l.country_id
        JOIN regions   r ON r.region_id = c.region_id;
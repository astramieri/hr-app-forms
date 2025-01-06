update employees j
set
    j.hire_date = add_months(j.hire_date, 12 * 9)
where
    j.employee_id in (
        select
            e.employee_id
        from
            employees e
        where
            not exists (
                select
                    null
                from
                    job_history h
                where
                    h.employee_id = e.employee_id
            )
                and extract(year from e.hire_date) = 2012
        order by
            e.hire_date asc
        fetch first 3 rows only
    );
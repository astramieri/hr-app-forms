CREATE OR REPLACE TRIGGER update_job_history AFTER
    UPDATE OF job_id, department_id ON employees
    FOR EACH ROW
BEGIN
    IF :old.job_id <> :new.job_id
    OR :old.department_id <> :new.department_id THEN
        add_job_history(:old.employee_id,
                        :old.hire_date,
                        sysdate,
                        :old.job_id,
                        :old.department_id);

    END IF;
END update_job_history;
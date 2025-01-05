create or replace procedure insert_log (
    p_message in varchar2
) is
    pragma autonomous_transaction;
begin
    insert into log ( log_message ) values ( p_message );

    commit;
exception
    when others then
        rollback;
        
        raise;
end insert_log;
/
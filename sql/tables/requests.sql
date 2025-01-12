drop sequence requests_seq;

create sequence requests_seq nocache;

drop table requests;

create table requests (
    request_id  number,
    employee_id number,
    start_date  date not null,
    end_date    date not null,
    reason      varchar2(100),
    status      varchar2(50),
    created     date,
    updated date
);

alter table requests 
    add constraint requests_pk primary key ( request_id );

alter table requests
    add constraint requests_fk_01 foreign key ( employee_id )
        references employees ( employee_id );

create or replace trigger requests_trg_01 
    before insert or update on requests
    for each row
declare
    v_sysdate date := sysdate;
begin
    if inserting then 
        :new.request_id := requests_seq.nextval;
        :new.created    := v_sysdate;
    end if;
    
    :new.updated := v_sysdate;
end requests_trg_01;
/
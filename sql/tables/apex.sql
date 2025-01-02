drop table hr.apex;

create table hr.apex (
   id           number(10)      not null, 
   protocol     varchar2(100)   not null,  
   hostname     varchar2(100)   not null,  
   port         varchar2(100)   not null,  
   workspace    varchar2(100)   not null,  
   application  varchar2(100)   not null,  
   page         varchar2(100)   not null,
   created      timestamp(6)    not null,
   updated      timestamp(6)    not null
);

alter table hr.apex
   add constraint apex_pk primary key (id);
   
create or replace trigger hr.apex_trg_01
   before insert or update on apex
   for each row
declare
   v_systimestamp timestamp := systimestamp;
begin
   if inserting then
      :new.created := v_systimestamp;
   end if;
   
   :new.updated := v_systimestamp;
end apex_trg_01;
/

insert into hr.apex (
    id,
    protocol,
    hostname,
    port,
    workspace,
    application,
    page
) values (
    100,
    'http', 
    'localhost',
    '8080',
    'hr_dev',
    'hr-app',
    'home'
);

commit;
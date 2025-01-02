drop sequence hr.users_seq;

create sequence hr.users_seq nocache;

drop table hr.users;

create table hr.users (
   id           number(10)      not null, 
   username     varchar2(100)   not null,  
   password     varchar2(100)   not null,
   role         varchar2(100)   not null,
   created      timestamp(6)    not null,
   updated      timestamp(6)    not null
);

alter table hr.users
   modify (id default hr.users_seq.nextval);

alter table hr.users
   add constraint users_pk primary key (id);
   
alter table hr.users
   add constraint users_uk_01 unique (username);
   
create or replace trigger hr.users_trg_01
   before insert or update on users
   for each row
declare
   v_systimestamp timestamp := systimestamp;
begin
   if inserting then
      :new.created := v_systimestamp;
   end if;
   
   :new.updated := v_systimestamp;
end users_trg_01;
/

insert into hr.users (username, password, role) 
              values ('ADMIN', 
                      'admin#123',
                      'ADMIN_ROLE');

insert into hr.users (username, password, role) 
              values ('USER', 
                      'user#123',
                      'USER_ROLE');

commit;
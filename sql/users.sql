create table users (
    username varchar2(50) not null,
    password varchar2(50) not null
);

insert into users (username, password) values ('admin', 'admin123');

commit;
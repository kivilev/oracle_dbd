drop table client_demo_lock;
create table client_demo_lock
(
  client_id number not null,
  node_name varchar2(50 char)
);

insert into client_demo_lock values (1, null);
insert into client_demo_lock values (2, null);
commit;

select * from client_demo_lock;

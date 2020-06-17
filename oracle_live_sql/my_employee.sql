drop table my_employee;
drop sequence my_employee_seq;

-- create table
create table my_employee
(
  id     number not null,
  fio   varchar2(1000 char) not null,
  salary number(10,2) not null
);
-- add comments to the table 
comment on table my_employee is 'Сотрудники';

-- add comments to the columns 
comment on column my_employee.id is 'UID';
comment on column my_employee.fio is 'ФИО';
comment on column my_employee.salary is 'Зарплата';

-- create/recreate primary, unique and foreign key constraints 
alter table my_employee
  add constraint my_employee_pk primary key (id);

-- create/recreate check constraints 
alter table my_employee
  add constraint my_employee_salary_ch
  check (salary > 0);


create sequence my_employee_seq;

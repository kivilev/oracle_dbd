---- Создание роли и двух схем для демо

drop user hr cascade;
drop user hr_ebr cascade;
drop role simple_user_role;

create role simple_user_role;
grant connect to simple_user_role;
grant resource to simple_user_role;
grant debug connect session to simple_user_role;
grant create view to simple_user_role;
grant select_catalog_role to simple_user_role;

-- HR без EBR
create user hr identified by booble12
default tablespace ts_students temporary tablespace temp profile
default quota 300M on ts_students;

-- HR с EBR
create user hr_ebr identified by booble12
default tablespace ts_students temporary tablespace temp profile
default quota 300M on ts_students;

grant simple_user_role to hr;
grant simple_user_role to hr_ebr;

--вкл поддержки EBR на уровне схемы
alter user hr_ebr enable editions;

-- свойство у пользователя
select t.editions_enabled, t.* from dba_users t where t.username in ('HR', 'HR_EBR');

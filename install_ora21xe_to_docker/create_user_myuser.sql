-- ******** Создание пользователя MYUSER **********

-- drop user myuser cascade;

create user myuser
identified by booble34
default tablespace users
temporary tablespace temp
profile default
quota unlimited on users;
  
grant resource to myuser;
grant connect to myuser;


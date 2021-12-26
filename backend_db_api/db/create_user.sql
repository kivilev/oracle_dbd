/*
  Создание пользователя для размещения объектов

  Автор: Кивилев Д.С.
*/

-- drop user payment_core cascade;

create user payment_core
identified by booble12
default tablespace ts_students
temporary tablespace temp
profile default
quota 500m on ts_students;
  
grant connect to payment_core;
grant resource to payment_core;
grant create view to payment_core;
grant debug connect session to payment_core;

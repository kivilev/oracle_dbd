/*
  Автор: Кивилев Д.С. (https://t.me/oracle_dbd, https://oracle-dbd.ru, https://www.youtube.com/c/OracleDBD)
  Дата: 22.03.2021
  
  Описание скрипта: примеры получения плана запроса
*/

-- 1 способ
alter session set statistics_level = all;

select e.*, d.department_name
  from hr.employees e
  join hr.departments d on e.department_id = d.department_id
 where e.first_name = 'John'
   and e.salary >= 8000;

select * from table(dbms_xplan.display_cursor('','','ALLSTATS ADVANCED LAST'));

-- 2 способ

set autotrace traceonly;

select e.*, d.department_name
  from hr.employees e
  join hr.departments d on e.department_id = d.department_id
 where e.first_name = 'John'
   and e.salary >= 8000;
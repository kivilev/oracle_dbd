------- Реальные планы выполнения

--- 1й способ. autotrace
-- grant plustrace to hr;
set autotrace traceonly;
select * from hr.employees t where t.employee_id = 102;


--- 2й способ для ни разу не выполнявшегося запроса
-- Примечание. В IDE может не сработать из-за того что за кадром выполняются другие запросы
-- grant select on v_$session to hr; 
-- grant select on v_$sql_plan_statistics_all to hr;

/*+ gather_plan_statistics */

alter session set statistics_level = all;

select * from hr.employees t where t.employee_id = 103;

select * from table(dbms_xplan.display_cursor('','','ALLSTATS ADVANCED LAST'));


--- 3й способ
-- выполним запрос (эмуляция выполнявшегося запроса когда-то)
select * from hr.employees t where t.employee_id = 104;

-- найдем его sql_id
select * from v$sql t where lower(t.sql_fulltext) like '%t.employee_id = 104%';

-- посмотрим есть ли по нему статистика
select * from v$sql_plan t where t.sql_id = '2chv128hyhurq';

-- получаем план выполения с подробной статой.
select * from table(dbms_xplan.display_cursor(sql_id => '2chv128hyhurq', format => 'ALLSTATS ADVANCED'));


--- 4й способ
-- берем sql_id
-- получаем план выполения с подробной статой. 
-- для Oracle11g используйте dbms_xplan.display_awr
select * from dbms_xplan.display_workload_repository(sql_id => '1dj19hu0u7rnv', format => 'ALLSTATS ADVANCED +cost +bytes');




--- 5й способ

-- берем sql_id
select t.sql_id from v$sql_monitor t; --выбрем запрос для примера

-- получаемм план выполения с подробной статой в HTML
select dbms_sqltune.report_sql_monitor(sql_id => 'bt7j4k81u39gh', type => 'HTML', report_level => 'ALL') report from dual;


-- Гипотетический план

-- способ 1. IDE

-- способ 2. Выполнение команд
explain plan set statement_id = 'MY_QUERY1' for 
select * from employees t where t.employee_id = 101;

select level, plan_table.* from plan_table where statement_id = 'MY_QUERY'
connect by prior id = parent_id and statement_id = 'MY_QUERY'
start with id = 0 and statement_id = 'MY_QUERY'
order by id;

-- или

select * from dbms_xplan.display(format =>'ADVANCED +partition');


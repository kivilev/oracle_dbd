--- Вывод актуального плана выполнения (обход особенностей IDE)
begin
  dbms_output.enable();
  
  execute immediate 'alter session set statistics_level = ALL';
  
  
  for test in (
               -------------
               -- сюда вставляем запрос  
               -------------
               select * from hr.employees t where t.employee_id = 103

               ) loop
    null;
  end loop;
   
  for x in (select p.plan_table_output
              from table(dbms_xplan.display_cursor(null,
                                                   null,
                                                   'ALLSTATS ADVANCED')) p) loop
    dbms_output.put_line(x.plan_table_output);
  end loop;
  rollback;
end;
/

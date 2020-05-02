--- Пример 3. Информация по кэшированию (под привелегированным пользователем!)

-- отчет о кэше
begin
   dbms_result_cache.memory_report();
end;
/

-- статистика по кэшированию
select * from v$result_cache_statistics; 

-- что есть в кэше
select t.name, count(*) 
  from v$result_cache_objects t 
 where t.name like upper('%result_cache_func%') or t.name like upper('%result_cache_data_func%')
 group by t.name;

select * 
  from v$result_cache_objects t 
 where t.name like upper('%result_cache_data_func%');

-- очистка кэша
declare
  v_res boolean;
begin
  sys.dbms_result_cache.bypass (true);
  v_res := sys.dbms_result_cache.Flush();
  sys.dbms_result_cache.bypass (false);  
end;
/ 

-- статус кэширование - вкл\выкл
select sys.dbms_result_cache.status from dual;

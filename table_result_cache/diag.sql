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
 --where t.name like upper('%result_cache_func%') or t.name like upper('%result_cache_data_func%')
 group by t.name;

select * 
  from v$result_cache_objects t 
 where t.name like upper('%D_KIVILEV.MYTAB1%');
 
select * from dba_users

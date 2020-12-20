---- Пример 1. Используем версию СУБД

-- создадим свою процедуру с засыпанием
create or replace procedure sleep(sleep_sec number) is
begin
 $if dbms_db_version.version >= 12 $then
   dbms_session.sleep(sleep_sec);
 $else
   dbms_lock.sleep(sleep_sec);
 $end
end;
/

-- вызываем
call sleep(2);

-- исходный код
select * from user_source s where s.name = 'SLEEP' and s.type = 'PROCEDURE' order by s.line;

-- скомпилированный код
begin
   dbms_preprocessor.print_post_processed_source(
      object_type => 'PROCEDURE',
      schema_name => USER,
      object_name => 'SLEEP'
   );
end;
/

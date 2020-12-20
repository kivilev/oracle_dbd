---- Пример 2. Разница для DEV и PROD

-- создадим процедуру
create or replace function trimlow(p_value varchar2) return varchar2 is
begin
 $if $$DEV $then
   dbms_output.put_line('Исходная строка: '||p_value);
   dbms_output.put_line('После преобразования: '||trim(lower(p_value)));
 $end

 return trim(lower(p_value));
end;
/

-- вызываем
select trimlow(' Что-То ') res from dual;

-- исходный код
select * from user_source s where s.name = 'TRIMLOW' and s.type = 'FUNCTION' order by s.line;

-- скомпилированный код
begin
   dbms_preprocessor.print_post_processed_source(
      object_type => 'FUNCTION',
      schema_name => USER,
      object_name => 'TRIMLOW'
   );
end;
/

-- установим флажок DEV и скомпилируем заново
-- 1 способ. 
alter session set plsql_ccflags = 'DEV:true';
alter function trimlow compile;

-- 2 способ.
alter function trimlow compile plsql_ccflags = 'DEV:true' reuse settings;


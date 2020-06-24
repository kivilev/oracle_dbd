-- ************* 3. Обработка неименованных системных исключений ************

-- Создадим табличку
drop table demo1;
create table demo1
(
id number not null
);
insert into demo1 values (null);
sys.standard;

--- Пример 1. Пытаемся вставить null-значение (others + sqlcode)
begin
  insert into demo1 values (null);     
exception 
  when others then -- Так сибе путь
    if sqlcode = -01400 then
      dbms_output.put_line('Возможно, конечно, так обрабатывать, но шляпа :)');    
    else --! момент
      raise;
    end if;
end;
/

-- Пример 2. Пытаемся вставить null-значение (exception + pragma)
declare
  e_null exception;
  pragma exception_init(e_null, -01400);
begin
  insert into demo1 values (null);     
exception 
  when e_null then
    dbms_output.put_line('Путь джедая по обработке ошибок.');
end;
/



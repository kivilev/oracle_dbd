---- Пример 1. Преимущества функций с кэшированием результатов

-- обычная функция
create or replace function simple_func return number
is
begin
  dbms_session.sleep(2);-- спим N сек
  return 1;
end;
/

-- функция с кэшированем
create or replace function result_cache_func return number
result_cache
is
begin
  dbms_session.sleep(2);-- спим N сек
  return 1;
end;
/


-- Вызываем обычную функцию
select simple_func() from dual;

-- Вызываем несколько раз функцию с кэшированием результатов
select result_cache_func() from dual;


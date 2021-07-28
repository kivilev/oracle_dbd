-------- Пример 2. Основное свойство pipelined-функции

-- функция для получения времени вне зависимости от основного запроса
create or replace function get_actual_dtime return date
is
  pragma autonomous_transaction;
begin
  commit;
  return sysdate;
end;
/

-- Заполняем таблицу из обычной функции
select 'delay_simple', value(t), get_actual_dtime()
  from table(delay_simple()) t;  

-- Заполняем таблицу из конвейерной функции
select 'pipelined', value(t), get_actual_dtime()
  from table(delay_pipelined()) t;

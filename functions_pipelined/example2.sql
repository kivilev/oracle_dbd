---------------- Эксперимент 2. Фиксируем время возврата строки

-- функция для получения timestamp именно на момент вставки
create or replace function get_actual_dtime return date
is
  pragma autonomous_transaction;
begin
  commit;
  return sysdate;
end;
/

-- Заполняем таблицу из обычной функции
select 'delay_simple', value(t), get_actual_timestamp()
  from table(delay_simple()) t;  

-- Заполняем таблицу из конвейерной функции
select 'pipelined', value(t), get_actual_timestamp()
  from table(delay_pipelined()) t;

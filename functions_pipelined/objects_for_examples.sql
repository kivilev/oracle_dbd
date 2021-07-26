------ Объекты для примеров

-- Создаем коллекцию
create or replace type t_numbers is table of number(10);
/

---- Обычная процедура
create or replace function delay_simple(p_count number := 5, p_delay_sec number := 1) return t_numbers 
is
  v_out t_numbers := t_numbers();
begin
  -- генерируем N строк
  for i in 1..p_count
  loop
    dbms_session.sleep(p_delay_sec); -- спим p_delay сек. dbms_lock для Oracle 11
    v_out.extend(1);
    v_out(v_out.last) := i;
  end loop;
  
  return v_out; -- вернуть весь результат 
end;
/

---- Конвейерная процедура
create or replace function delay_pipelined(p_count number := 5, p_delay_sec number := 1) return t_numbers 
PIPELINED
is  
begin
  -- генерируем N строк
  for i in 1..p_count
  loop
    dbms_session.sleep(p_delay_sec); -- спим p_delay сек. dbms_lock для Oracle 11
    PIPE ROW(i);-- возврат строки сразу
  end loop;
end;
/
  

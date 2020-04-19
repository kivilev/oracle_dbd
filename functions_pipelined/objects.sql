-- Создаем коллекцию
create or replace type t_numbers is table of number(10);
/


---- Обычная процедура
create or replace function delay_simple return t_numbers 
is
  v_out t_numbers := t_numbers();
begin
  -- генерируем 10 строк отсортированных от 5 до 1
  for i in (select level 
              from dual connect by level <= 5
             order by level desc)
  loop
    dbms_session.sleep(1); -- спим 1 сек. dbms_session для Oracle 12.
    --dbms_lock.sleep(1); -- если у вас Oracle 11 расскоментируйте, а выше строку закомментируйте
    v_out.extend(1);
    v_out(v_out.last) := i.level;
  end loop;
  
  return v_out; -- вернуть весь результат 
end;
/

---- Конвейерная процедура
create or replace function delay_pipelined return t_numbers 
PIPELINED
is  
begin
  -- генерируем 10 строк отсортированных от 5 до 1
  for i in (select level 
              from dual connect by level <= 5 
             order by level desc)
  loop
    dbms_session.sleep(1); -- спим 1 сек. dbms_session для Oracle 12.
    --dbms_lock.sleep(1); -- если у вас Oracle 11 расскоментируйте, а выше строку закомментируйте
    PIPE ROW(i.level);-- возврат строки сразу
  end loop;
end;
/


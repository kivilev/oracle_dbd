-- ****************** 2. Пользовательские исключения ***********

-- Пример 1. Пользовательское исключение e_no_money определенное через объект exception
-- ORA-06510: PL/SQL: unhandled user-defined exception (Вызывающая среда не знает что есть e_no_money).
declare
  e_no_money exception;
  v_money    number(10,2) := 0;
begin
  if v_money = 0 then
    raise e_no_money; -- возбуждаем исключение
  end if;
end;
/

-- Пример 2. Пользовательское исключение определенное через raise_application_error
declare
  v_money    number(10,2) := 0;
begin  
  if v_money = 0 then
    raise_application_error(-20100, 'Денег нет, но вы держитесь');
  end if;
end;
/


-- Пример 3. Комбинированный вариант. С перехватом пользовательского исключения exception.
declare
  e_no_money exception;
  v_money    number(10,2) := 0;
begin
  
  if v_money = 0 then
    raise e_no_money;
  end if;

exception 
  when e_no_money then
     raise_application_error(-20100, 'Денег нет, но вы держитесь');
end;
/

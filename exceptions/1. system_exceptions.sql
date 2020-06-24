-- ****************** 1. Системные исключения ***************

sys.standard;

--Пример 1. Возникновение неименованного исключения в run-time
-- ORA-06502: PL/SQL: numeric or value error: character to number conversion error
declare
  v number;
begin
  select *
    into v
   from dual;
end;
/

-- Пример 2. Возникновение именованного исключения в run-time
-- ORA-01476: divisor is equal to zero
declare
  v number := 10;
  v2 number := 0;
begin
  v := v/v2;
end;
/

-- Пример 3. Вызов вручную именнованного системного исключения.
-- ORA-01476: divisor is equal to zero
begin
  raise ZERO_DIVIDE;  
end;
/

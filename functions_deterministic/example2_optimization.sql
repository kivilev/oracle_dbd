------ Оптимизация с использованием determinstic-функций

-- создадим функцию умножения
create or replace function multiply(p_a number, p_b number) return number
deterministic
is
begin
  dbms_session.sleep(1);-- спим 1 секунду
  dbms_output.put_line ('multiply. p_a: '||p_a||'. p_b: '|| p_b);-- нарушаю свойство deterministic =)

  return p_a * p_b;-- перемножаем формальные параметры
end;
/

-- выполним 10 итераций с одинаковыми параметрами => посмотрим вывод
select multiply(2, 2) val
  from dual
connect by level <= 10;

-- выполним 10 итераций с небольшим разнообразием параметров => посмотрим вывод
select  mod(level, 3) p1,  mod(level, 3) p2, multiply(mod(level, 3), mod(level, 3)) val
  from dual
connect by level <= 10;

-- pl/sql
declare
  v number;
begin
  for i in 1 .. 10 loop
    v := multiply(2, 2);
  end loop;
end;
/

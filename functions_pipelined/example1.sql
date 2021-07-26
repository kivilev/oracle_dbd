----- Пример 1. Pipelined функции с объектами

-- объект
create or replace type t_person is object(
  id number,
  full_name varchar2(200 char)
);
/
-- коллекция объектов
create or replace type t_person_arr is table of t_person;
/

-- конвейерная функция
create or replace function get_persons return t_person_arr
pipelined 
is
begin
  -- генерируем 10 строк
  for i in 1..10 loop
    -- возвращаем результат
    pipe row(t_person(i, 'full_name_'||i));
  end loop;
end;
/

-- вызываем (<12)
select * from table(get_persons());

-- вызываем (12+)
select * from get_persons();


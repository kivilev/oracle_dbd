--- Пример. Чистой/детерминированной/deterministic функции на примере функционального индекса

-- создадим функцию умножения
create or replace function multiply(p_a number, p_b number) return number
deterministic
is
begin
  return p_a * p_b;-- перемножаем формальные параметры
end;
/

-- drop table rectangle;

create table rectangle (
  figure_id number(30) primary key,
  side_a    number(10,2) not null,
  side_b    number(10,2) not null
);
insert into rectangle select level, level, level from dual connect by level <= 100;
commit;

-- ORA-30553: The function is not deterministic
create index rectangle_square_idx on rectangle(multiply(side_a, side_b));

-- посмотреть план
select * from rectangle t where multiply(side_a, side_b) = 4;



-------- Пример 3. Использование в SQL

------ 3.1. Без ограничений (выполнятся одинаково за 5 сек)

-- обычная
select * from delay_simple(p_count => 5);

-- конвейерная
select * from delay_pipelined(p_count => 5);


------ 3.2. Ограничение по количеству строк через rownum

-- обычная (выполняется 5 сек)
select * 
  from table(delay_simple(p_count => 5)) t
 where rownum <= 2;

-- конвейерная (выполняется 2 сек)
select * 
  from table(delay_pipelined(p_count => 5)) t
 where rownum <= 2;

 
------ 3.3. Ограничение по какому-то значению

-- обычная (выполняется 5 сек)
select * 
  from table(delay_simple(p_count => 5)) t
 where value(t) in (1,3);

-- конвейерная (выполняется 5 сек)
select * 
  from table(delay_simple(p_count => 5)) t
 where value(t) in (1,3);

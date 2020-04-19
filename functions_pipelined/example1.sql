------------- Эксперимент 1. Ограничение по выборке

------ 1.1. Без ограничений (выполнятся одинаково за 10 сек)
-- обычная
select * from delay_simple();
-- конвейерная
select * from delay_pipelined();


------ 1.2. Ограничение по количеству строк через rownum

-- обычная (выполняется 5 сек)
select * 
  from table(delay_simple()) t
 where rownum <= 3;

-- конвейерная (выполняется 3 сек)
select * 
  from table(delay_pipelined()) t
 where rownum <= 3;

 
------ 1.3. Ограничение по какому-то значению

-- обычная (выполняется 10 сек)
select * 
  from table(delay_simple()) t
 where value(t) in (1,3);

-- конвейерная (выполняется 10 сек)
select * 
  from table(delay_simple()) t
 where value(t) in (1,3);

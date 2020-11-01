---- 3. Особенности

-- Создадим таблицы
create private temporary table ora$ptt_my_tab_trans ( 
id number(30)
); -- по умолчанию удалять по коммиту

create private temporary table ora$ptt_my_tab_sess ( 
id number(30)
)  
on commit preserve definition;


-- в общем системном словаре информации нет
select * from user_tables t where upper(t.table_name) in('ORA$PTT_MY_TAB_TRANS', 'ORA$PTT_MY_TAB_SESS');

-- в специальном словаре есть
select * from user_private_temp_tables;

----- CTAS
create private temporary table ora$ptt_my_tab_ctas
on commit drop definition
as select level lvl from dual connect by level <= 10000;

-- статистика была собрана динамически на момент создания (num_rows, blocks, ...)
select * from user_private_temp_tables;

-- вставим 10К элементов в первую таблицу
insert into ora$ptt_my_tab_trans
select level lvl from dual connect by level <= 10000;

-- статистика по ora$ptt_my_tab_trans не изменилась.
select * from user_private_temp_tables;



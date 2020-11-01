----- 2. Именование

-- нельзя создать без префикса ora$ptt_ => ORA-00903: invalid table name
create private temporary table my_tab_sess ( 
id number(30)
)  
on commit preserve definition;

-- с префиксом можно
create private temporary table ora$ptt_my_tab_sess ( 
id number(30)
)  
on commit preserve definition;


-- обычную таблицу нельзя создать с префиксом ora$ptt_ => 
-- ORA-32463: cannot create an object with a name matching private temporary table prefix
create table ora$ptt_my_tab ( 
id number(30)
);


-- префикс установленный по умолчанию можно посмотреть в параметрах под привелигерованным пользователем.
select * from v$parameter t where upper(t.name) = 'PRIVATE_TEMP_TABLE_PREFIX';


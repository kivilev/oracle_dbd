---- 1. Создание таблиц

create private temporary table ora$ptt_my_tab_trans ( 
id number(30)
)  
on commit drop definition; -- существует до коммита


create private temporary table ora$ptt_my_tab_sess ( 
id number(30)
)  
on commit preserve definition; -- существует до конца сессии

-- обратимся
select * from ora$ptt_my_tab_trans;
select * from ora$ptt_my_tab_sess;

-- зафиксируем транзакцию
commit;

-- обратимся повторно
select * from ora$ptt_my_tab_trans; -- будет ошибка, т.к. таблица после фиксации уже не существует
select * from ora$ptt_my_tab_sess;



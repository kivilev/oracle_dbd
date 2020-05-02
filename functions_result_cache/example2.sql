---- Пример 2. Сброс кэша после изменения источника данных
drop table demo_tab;
create table demo_tab
(
   id number(30) not null,
   name varchar2(300 char) not null
);

insert into demo_tab
select level, 'name_'||level 
  from dual connect by level <= 100;
commit;


create or replace function result_cache_data_func(p_id demo_tab.id%type) return demo_tab.name%type
result_cache
is
  v_name demo_tab.name%type;
begin
  select name 
    into v_name
    from demo_tab
   where id = p_id;
  
  dbms_session.sleep(2);-- спим 2 сек
  return v_name;
end;
/

-- Вызываем 1й раз. Время выполнения 2 сек для каждого вызова.
select result_cache_data_func(55) from dual;
select result_cache_data_func(56) from dual;

-- Вызываем 2й раз Время выполнения -> 0 секундам. Т.к. уже закэширован результат.
select result_cache_data_func(55) from dual;
select result_cache_data_func(56) from dual;

-- Обновим строчку c id = 55. Тем самым сбросится весь кэш для этой процедуры
update demo_tab set name = 'new value' where id = 1;
commit;

-- Вызываем 3й раз. Время выполнения 2 сек для каждого вызова, т.к. кэш был сброшен
select result_cache_data_func(55) from dual;
select result_cache_data_func(56) from dual;


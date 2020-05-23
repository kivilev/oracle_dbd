-- *********** Домашнее задание ************
-- создаем объект из двух полей
create or replace type t_my_obj force is object
(
  id   number(30),
  name varchar2(300 char)
);
/
-- создаем коллекцию объектов
create or replace type t_my_objs is table of t_my_obj;
/

-- создаем таблицу для вставки
drop table hometask;
create table hometask
(
  some_id   number(30),
  some_name varchar2(300 char)
);

declare
  -- инициализация
  v_coll t_my_objs := t_my_objs(t_my_obj(100, 'elem100'), t_my_obj(200, 'elem200'));
begin
  -- создание нового элемента
  v_coll.extend(1);
  v_coll(v_coll.last) := t_my_obj(300, 'elem300');
  
  -- вывод количества
  dbms_output.put_line('Coll Count: '|| v_coll.count());

  -- вывод элементов
  if v_coll is not empty then
     for i in v_coll.first..v_coll.last loop
      dbms_output.put_line('Coll['||i||']= '||v_coll(i).id||':'||v_coll(i).name); 
    end loop;
  end if;
  
  -- вставка
  insert into hometask
  select value(t).id, value(t).name
    from table(v_coll) t;
end;
/

select * from hometask;

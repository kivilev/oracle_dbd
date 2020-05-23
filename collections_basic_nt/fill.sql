-- *************** Заполнение коллекций ***************

-- 1) При инициализации
declare
  v_schema_coll t_numbers := t_numbers(1, 5, 3);
  
  v_pack_coll   my_pack.t_pack_numbers := my_pack.t_pack_numbers(1, 5, 3, -2);
  
  type t_local_numbers is table of number(30);
  v_local_coll t_local_numbers := t_local_numbers(1, 5, 3, 100, 101);
begin
  dbms_output.put_line('Schema Coll count: '|| v_schema_coll.count()); 
  dbms_output.put_line('Pack Coll count: '|| v_pack_coll.count());
  dbms_output.put_line('Local Coll Count: '|| v_local_coll.count());
end;
/

-- 2) Заполнение в run-time через команды коллекции
declare
  v_schema_coll t_numbers := t_numbers();
begin
  v_schema_coll.extend(); 
  v_schema_coll(v_schema_coll.last) := 100;
  v_schema_coll.extend(); 
  v_schema_coll(v_schema_coll.last) := 200;  

  dbms_output.put_line('Schema Coll count: '|| v_schema_coll.count()); 
end;
/

-- 3) Заполнение через SQL (select)
declare
  v_schema_coll t_numbers;
begin
  select level
    bulk collect into v_schema_coll
    from dual  
  connect by level <= 10;
  dbms_output.put_line('Schema Coll count: '|| v_schema_coll.count()); 
end;
/

-- 4) Заполнение через DML операции (update, delete)
drop table my_tab;
create table my_tab
(
  id        number(30),
  some_data number(30)
);

insert into my_tab 
select level, level
  from dual connect by level <= 10;
commit;

select * from my_tab;

declare
  v_schema_coll t_numbers;
begin
  -- удаленные id сохраняем в коллекцию
  delete from my_tab
   where id in (1, 4, 6, 100)
   returning some_data bulk collect into v_schema_coll;

  dbms_output.put_line('Schema Coll count: '|| v_schema_coll.count()); 

  -- проход по коллекции с выводом элементов
  if v_schema_coll is not empty then
    for i in v_schema_coll.first..v_schema_coll.last loop
      dbms_output.put_line('Coll['||i||']= '||v_schema_coll(i)); 
    end loop;
  end if;
  rollback;
end;
/



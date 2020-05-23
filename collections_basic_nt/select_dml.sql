-- ***************** Использование в SELECT и DML ************* 
-- ! Использовать можно только типы на уровне пакетов

drop table my_tab;
create table my_tab
(
  id number(30)
);

-- INSERT
declare
  v_schema_coll t_numbers := t_numbers(1, 5, 3, 100);
begin
  insert into my_tab 
  select value(t)
    from table(v_schema_coll) t;
  commit;
end;
/

select * from my_tab;


-- SELECT
declare
  v_schema_coll t_numbers := t_numbers(1, 100);
  v_sum_ids     my_tab.id%type;
begin
  select sum(t.id)
    into v_sum_ids 
    from my_tab t
    join table(v_schema_coll) c on value(c) = t.id;
  
  dbms_output.put_line('Summ of ids: '||v_sum_ids); 
end;
/

-- DELETE
declare
  v_schema_coll t_numbers := t_numbers(1, 5);
begin
  delete my_tab t
    where t.id in (select value(t)
                     from table(v_schema_coll) t);
  commit;
end;
/
select * from my_tab;


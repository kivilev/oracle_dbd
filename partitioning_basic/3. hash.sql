------- Одноуровневое партиционирование. HASH

---- 1. HASH-партиционирования (по хешфункции)
drop table hash_tab;

create table hash_tab(
  order_id number,
  sernum varchar2(100),
  state_code varchar2(10)
)
partition by hash (order_id) 
(partition p1, partition p2, partition p3, partition p4);

-- вставляем записи
insert into hash_tab(order_id, sernum, state_code) values (1, '111', 'MA');
insert into hash_tab(order_id, sernum, state_code) values (2, '222', 'TX');
insert into hash_tab(order_id, sernum, state_code) values (3, '333', null);
insert into hash_tab(order_id, sernum, state_code) values (4, '444', 'ZZZ');
commit;


select * from hash_tab partition (p1);
select * from hash_tab partition (p2);
select * from hash_tab partition (p3);
select * from hash_tab partition (p4);


-- проверим распределение. вставим 128 записей
insert into hash_tab
select level, level, level from dual connect by level <= 128;

select 'p1', count(*) from hash_tab partition (p1)
union all
select 'p2', count(*) from hash_tab partition (p2)
union all
select 'p3', count(*) from hash_tab partition (p3)
union all
select 'p4', count(*) from hash_tab partition (p4);

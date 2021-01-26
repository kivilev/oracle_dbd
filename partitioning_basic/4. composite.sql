------- Составное (двухуровневое) секционирование - COMPOSITE

---- Пример 1. Range - list
drop table message_log;

-- создаем таблицу
create table message_log(
  mtype   char(1 char) default 'I',
  dtime   date default sysdate, -- в реальной задаче лучше timestamp
  message varchar2(200 char)
)
partition by range (dtime)
interval (interval '1' day)
subpartition by list (mtype)
subpartition template 
    (
    subpartition sp_error values ('W') ,
    subpartition sp_warning values ('E'),
    subpartition sp_info values ('I')
    )
(
  partition pmin values less than ( date '1900-01-01')
);
-- ограничение на тип сообщения
alter table message_log add constraint message_log_mtype_ch check (mtype in ('E', 'I', 'W'));


-- добавляем данные
insert into message_log values ('I', sysdate + 1, 'Info 1');
insert into message_log values ('I', sysdate - 1, 'Info 2');
insert into message_log values ('W', sysdate + 10, 'Warning 1');
insert into message_log values ('W', sysdate - 10, 'Warning 2');
insert into message_log values ('E', sysdate + 10, 'Error 1');
insert into message_log values ('E', sysdate - 10, 'Error 2');
commit;

-- все строки
select * from message_log;

-- соберем статистику
begin
  dbms_stats.gather_table_stats(ownname => user, tabname => 'MESSAGE_LOG');
end;
/  

-- смотрим, какие партиции и субпартиции созданы
select * from user_tab_partitions t where t.table_name = 'MESSAGE_LOG' order by t.partition_position;
select num_rows, t.* from user_tab_subpartitions t where t.table_name = 'MESSAGE_LOG' order by t.partition_position, t.subpartition_position;

select * from message_log subpartition(sys_subp4112);

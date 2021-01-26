------- Одноуровневое партиционирование. RANGE

---- 1. RANGE-партиционирование (по диапазону)
drop table range_tab;

create table range_tab(
  order_id number,
  sernum varchar2(100 char),
  order_date date
)
partition by range (order_date) -- диапазон
(
  partition pmin values less than (date'2008-01-01'), -- самая минимальная граница
  partition p200802 values less than (date'2008-02-01'), -- какая-то промежуточная партиция
  partition p200803 values less than (date'2008-03-01'), -- какая-то промежуточная партиция
  partition pmax values less than (maxvalue) -- самая максимальная граница
);

-- вставляем записи
insert into range_tab(order_id, sernum, order_date) values (1, '111', sysdate); -- попадет в pmax
insert into range_tab(order_id, sernum, order_date) values (2, '222', date'2008-02-01'); -- попадет в p200803
insert into range_tab(order_id, sernum, order_date) values (3, '333', date'2001-12-20'); -- попадет в pmin
commit;

-- смотрим партиции, в какие куда вошли записи
select * from range_tab partition (pmin); -- то что находится в самой нижней партиции
select * from range_tab partition (p200802); -- то что находится в промежуточной
select * from range_tab partition (p200803); -- то что находится в промежуточной
select * from range_tab partition (pmax); -- то что находится в максимальной партиции

select * from range_tab; -- все строки

-- партиции в системном словаре
select * from user_tab_partitions t where t.table_name = 'RANGE_TAB';


---- 2. RANGE-партиционирование (по диапазону) + опция с автоматическим нарезанием
drop table auto_range_tab;

create table auto_range_tab(
  order_id number,
  sernum varchar2(100 char),
  order_date date
)
partition by range (order_date)
interval(interval '1' day) -- интервал нарезки 1 день
-- interval(interval '1' month) -- интервал нарезки 1 месяц
-- interval(interval '1' year) -- интервал нарезки 1 год
(
  partition pmin values less than (date'2008-01-01') -- самая минимальная граница
);

-- вставка
insert into auto_range_tab(order_id,
                           sernum,
                           order_date)
select level, 'sernum_'||level, sysdate + level from dual connect by level <= 10;
commit;

-- смотрим, что в таблице
select * from auto_range_tab order by order_date;

-- смотрим, какие секции созданы
select * from user_tab_partitions t where t.table_name = 'AUTO_RANGE_TAB';


drop table warehouse;

create table warehouse
(
  product_id     number(10) not null,
  rest           number(20) not null
);

-- На складе есть 100 единиц товара с ID = 1
insert into warehouse values (1, 100);
commit;

select * from warehouse;

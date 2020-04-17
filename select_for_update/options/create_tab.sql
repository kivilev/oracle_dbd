--- Таблица для демонстрации блокировок
drop table wallet;

create table wallet(
  wallet_id number(30),
  balance   number(20,2)
);


-- два кошелека с балансами
insert into wallet values (1, 100);
insert into wallet values (2, 200);
commit;

select * from wallet;

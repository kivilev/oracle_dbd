------- 1) Подготовка структур для примера

-- 1. Создаем таблицу со счетами клиента в валюте
drop table bank_account;
create table bank_account
(
  id          number(30)   not null,
  client_id   number(30)   not null,
  currency_id number(3)    not null,
  balance     number(20,2) not null
);
comment on table bank_account is 'Банковский счет клиента';
comment on column bank_account.id is 'UID';
comment on column bank_account.client_id is 'UID клиента';
comment on column bank_account.currency_id is 'Валюта счета';
comment on column bank_account.balance is 'Сумма на счете';

alter table bank_account add constraint bank_account_pk primary key (id); -- PK
alter table bank_account add constraint bank_account_client_cur_uq unique (client_id, currency_id); -- UNQ
alter table bank_account add constraint bank_account_cur_chk check (currency_id in (643, 810)); -- CHECK

-- 2. Создаем таблицу c мусором
drop table bank_account_in;
create table bank_account_in
(
  id          number(30),
  client_id   number(30),
  currency_id number(3),
  balance     number(20,2)
);

insert into bank_account_in values (1, 100, 643, 999); -- валидная запись.
insert into bank_account_in values (2, 101, 810, 9999); -- валидная запись.
insert into bank_account_in values (1, 101, 810, 9999); -- невалидная запись, повторяется ID = 1
insert into bank_account_in values (3, 101, 810, 0); -- невалидная запись, повторяется CLIENT_ID + CURRENCY_ID
insert into bank_account_in values (4, 102, 111, 0); -- невалидная запись, CURRENCY_ID = 111
commit;

select * from bank_account_in;

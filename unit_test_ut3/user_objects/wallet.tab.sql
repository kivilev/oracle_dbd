drop table wallet;

create table wallet
(
  wallet_id    number(30) not null,
  currency_id  number(10) not null,
  balance      number(30,2) default 0 not null
);

comment on table wallet is 'Кошелек';
comment on column wallet.wallet_id is 'UID';
comment on column wallet.currency_id is 'UID валюты';
comment on column wallet.balance is 'Баланс';

alter table wallet
  add constraint wallet_pk primary key (wallet_id);

/*
  Создание пользовательских объектов

  Автор: Кивилев Д.С.
*/

-------- Создание сущности "Клиент"
create table client
(
  client_id           number(30) not null,
  create_dtime_tech   timestamp(6) default systimestamp not null,
  update_dtime_tech   timestamp(6) default systimestamp not null,
  is_active           number(1) default 1 not null,
  create_dtime		  date default sysdate,
  first_name		  varchar2(200 char) not null,
  last_name		  varchar2(200 char) not null,
  middle_name		  varchar2(200 char),
  email			varchar2(200 char) not null,
  phone			varchar2(20 char) not null
);

comment on table client is 'Клиент';
comment on column client.client_id is 'Уникальный ID клиента';
comment on column client.is_active is 'Активен ли клиент. 1 - да, 0 - нет.';
comment on column client.create_dtime is 'Дата создания клиента - бизнесовая';
comment on column client.first_name is 'Имя';
comment on column client.last_name is 'Фамилия';
comment on column client.middle_name is 'Отчество';
comment on column client.email is 'Email';
comment on column client.phone is 'Телефон';
comment on column client.create_dtime_tech is 'Техническое поле. Дата создания записи в БД';
comment on column client.update_dtime_tech is 'Техническое поле. Дата обновления записи в БД';

alter table client add constraint client_pk primary key (client_id);
alter table client add constraint client_active_chk check (is_active in (0, 1));
alter table client add constraint client_tech_dates_chk check (create_dtime_tech <= update_dtime_tech);

--------- Последовательности ----------------------
create sequence client_seq;


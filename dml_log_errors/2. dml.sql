------- 2) Выполняем DML

---- 1. Обычный DML
insert into bank_account
select * from bank_account_in;

select * from bank_account;

---- 2. DML + Log_errors

-- Создаем таблицу логирования
begin
  dbms_errlog.create_error_log('bank_account', 'bank_account_error');   
end;
/
select * from bank_account_error;

-- DML
insert into bank_account 
select * from bank_account_in
log errors into bank_account_error(to_char(sysdate, 'YYYYMMDD_hh24miss')) reject limit unlimited;
commit;

select * from bank_account;
select * from bank_account_error;

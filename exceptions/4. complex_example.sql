-- ************** Комплексный пример ***************

drop table wallet;
create table wallet
(
   wallet_id    number(30) not null,
   balance      number(10,2) default 0 not null,
   hold_balance number(10,2) default 0 not null
);

insert into wallet values (1, 0, 0); -- пустой баланс
insert into wallet values (2, 200.20, 0); -- баланс не нулевой
insert into wallet values (3, 0, 300.30); -- захолдированный баланс не нулевой
insert into wallet values (666, 0, 0); -- спец кошелек, который удалять нельзя
commit;

---- пакет с исключениями
create or replace package exceptions_pack is
  e_have_money      exception; -- имеет бабло на основном балансе
  e_hold_money      exception; -- захолдированная сумма на балансе
  e_no_wallet_found exception; -- такого кошелька нет
  e_special_wallet  exception; -- пытаемся манипулировать спец кошельком
end;
/

---- пакет с функционалом
create or replace package wallet_api_pack is
 
  -- удаление кошелька
  procedure delete_wallet(p_wallet_id wallet.wallet_id%type);
  
end;
/

create or replace package body wallet_api_pack is

  -- удаление кошелька
  procedure delete_wallet(p_wallet_id wallet.wallet_id%type) is
    v_balance      wallet.balance%type;
    v_hold_balance wallet.hold_balance%type;
  begin
    -- проверка на спец кошелек
    if p_wallet_id = 666
    then
      raise exceptions_pack.e_special_wallet; -- возбмуждаем пользоват именован искл.
    end if;
  
    -- получаем балансы
    begin
      select t.balance
            ,t.hold_balance
        into v_balance
            ,v_hold_balance
        from wallet t
       where t.wallet_id = p_wallet_id;
    exception
      when no_data_found then
        -- перехват именнованного сист исключения
        raise exceptions_pack.e_no_wallet_found; -- возбмуждаем пользоват именован искл.
    end;
  
    -- баланс не нулевой
    if v_balance <> 0
    then
      raise exceptions_pack.e_have_money; -- возбмуждаем пользоват именован искл.
    end if;
  
    -- есть захолдированный баланс
    if v_hold_balance <> 0
    then
      raise exceptions_pack.e_hold_money; -- возбмуждаем пользоват именован искл.
    end if;
    
    delete from wallet where wallet_id = p_wallet_id;
  
  end;

end;
/

---- Тестируем
declare
  v_wallet_id wallet.wallet_id%type := 1;
  /* 1 - ок, 2 - баланс не нулевой, 3 - захолдированный баланс, 666 - спец кошелек, -1 - такого нет*/
begin
  -- попытка удалить кошелек
  wallet_api_pack.delete_wallet(p_wallet_id => v_wallet_id);
  dbms_output.put_line('wallet was deleted');
exception
     
  when exceptions_pack.e_have_money or exceptions_pack.e_hold_money  then -- баланс не нулевой
    raise_application_error(-20100, 'Баланс не нулевой. Удалить нельзя.');
    
  when exceptions_pack.e_no_wallet_found then -- кошелек не найден
    raise_application_error(-20100, 'Кошелек не найден.'); 
  
  when exceptions_pack.e_special_wallet then
    raise_application_error(-20100, 'Это спец кошелек. Удалить нельзя'); 
  
  when others then
    raise_application_error(-20999, 'Какая-то другая ошибка. SQLCODE: '||SQLCODE||'. Error: '||SQLERRM);
	raise;
end;
/


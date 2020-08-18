create or replace package body ut_wallet_api_pack is

  g_wallet_id wallet.wallet_id%type;


  --****************** процедура create_wallet *******************

  procedure create_wallet_with_valid_params is
    v_currency_id wallet.currency_id%type := wallet_api_pack.c_rub_code;
    v_balance     wallet.balance%type := 100;
    v_wallet_row  wallet%rowtype;
  begin
    -- дергаем API -> создаем кошелек
    g_wallet_id := wallet_api_pack.create_wallet(pi_currency_id => v_currency_id,
                                                 pi_balance     => v_balance);
    -- получаем созданный кошелек
    select *
      into v_wallet_row
      from wallet t
     where t.wallet_id = g_wallet_id;
  
    -- провеям данные в таблице  
    ut.expect(v_wallet_row.currency_id,
              'Созданная валюта счета отличается от заданной').to_equal(v_currency_id);
    ut.expect(v_wallet_row.balance,
              'Созданный баланс отличается от заданного').to_equal(v_balance);
  
  end;


  procedure create_wallet_with_wrong_currency is
    v_currency_id wallet.currency_id%type := -1;
    v_balance     wallet.balance%type := 100;
  begin
    -- дергаем API
    g_wallet_id := wallet_api_pack.create_wallet(pi_currency_id => v_currency_id,
                                                 pi_balance     => v_balance);
  end;


  procedure create_wallet_with_negative_balance is
    v_currency_id wallet.currency_id%type := wallet_api_pack.c_rub_code;
    v_balance     wallet.balance%type := -1;
  begin
    -- дергаем API
    g_wallet_id := wallet_api_pack.create_wallet(pi_currency_id => v_currency_id,
                                                 pi_balance     => v_balance);
  end;

  --****************** процедура delete_wallet ********************

  procedure delete_existing_wallet is
    v_cnt number;
  begin
    -- удаляем через API
    wallet_api_pack.delete_wallet(pi_wallet_id => g_wallet_id);
  
    -- проверяем, что действительно удалили
    select count(*)
      into v_cnt
      from wallet t
     where t.wallet_id = g_wallet_id;
  
    ut.expect(v_cnt,
              'Кошелек был найден после удаления').to_equal(0);
  end;


  procedure delete_non_existing_wallet is
    v_wallet_id wallet.wallet_id%type;
  begin
    -- получаем несущетвующий кошелек
    v_wallet_id := -dbms_random.value(10000, 2000000);
  
    -- вызываем API
    wallet_api_pack.delete_wallet(pi_wallet_id => v_wallet_id);
  end;


  procedure delete_wallet_with_null_wallet_id_leads_to_error is
  begin
    -- вызываем API
    wallet_api_pack.delete_wallet(pi_wallet_id => null);
  end;

  --****************** вспомогательные процедуры *************************

  -- создание кошелька для тестов
  procedure create_wallet_one is
    v_currency_id wallet.currency_id%type := wallet_api_pack.c_rub_code;
    v_balance     wallet.balance%type := 0;
  begin
    -- дергаем API -> создаем кошелек
    g_wallet_id := wallet_api_pack.create_wallet(pi_currency_id => v_currency_id,
                                                 pi_balance     => v_balance);
  end;

  -- удаление кошелька после тестов
  procedure delete_wallet_one is
  begin
    wallet_api_pack.delete_wallet(pi_wallet_id => g_wallet_id);
  end;

end;
/

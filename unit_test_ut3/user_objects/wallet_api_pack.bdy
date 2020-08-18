create or replace package body wallet_api_pack is

  -- создание кошелька
  function create_wallet
  (
    pi_currency_id wallet.currency_id%type
   ,pi_balance     wallet.balance%type := 0
  ) return wallet.wallet_id%type is
    v_res wallet.wallet_id%type;
  begin
    -- проверяем входные параметры
    if pi_currency_id is null
       or pi_balance is null
    then
      raise_application_error(c_error_code_wrong_input_param,
                              c_error_msg_null_params);
    end if;
  
    if pi_balance < 0 -- баланс не может быть отрицательным
    then
      raise_application_error(c_error_code_wrong_input_param,
                              c_error_msg_negative_balance);
    end if;
  
    if pi_currency_id not in (c_rub_code, c_usd_code)
    then
      raise_application_error(c_error_code_wrong_input_param,
                              c_error_msg_incorrect_currency_code);
    end if;
  
    -- вставка
    insert into wallet
      (wallet_id
      ,currency_id
      ,balance)
    values
      (wallet_seq.nextval
      ,pi_currency_id
      ,pi_balance)
    returning wallet_id into v_res;
    
    return v_res;
  
  end;

  -- удаление кошелька
  procedure delete_wallet(pi_wallet_id wallet.wallet_id%type) is
  begin
    -- проверяем входные параметры
    if pi_wallet_id is null
    then
      raise_application_error(c_error_code_wrong_input_param,
                              c_error_msg_null_params);
    end if;
  
    delete from wallet t where t.wallet_id = pi_wallet_id;
  end;

end;
/

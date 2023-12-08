﻿create or replace package ut_wallet_api_pack is

  -- Author  : D.KIVILEV
  -- Purpose : Unit-тесты для пакета wallet_pack_api


  --%suite(Test wallet_api_pack)
  --%suitepath(wallet)

  ----- кейсы для процедуры create_wallet

  --%test(Создание кошелька с валидными параметрами API)
  procedure create_wallet_with_valid_params;

  --%test(Создание кошелька с недопустимой валютой приводит к ошибке)
  --%throws(wallet_api_pack.c_error_code_wrong_input_param)
  procedure create_wallet_with_wrong_currency_leads_to_error;

  --%test(Создание кошелька с отрицательным балансом приводит к ошибке)
  --%throws(wallet_api_pack.c_error_code_wrong_input_param)
  procedure create_wallet_with_negative_balance_leads_to_error;

  ----- кейсы для процедуры delete_wallet

  --%test(Удаление существующего кошелька)
  --%beforetest(create_wallet_one)
  procedure delete_existing_wallet;

  --%test(Удаление несуществующего кошелька не приводит к ошибке)
  procedure delete_non_existing_wallet;

  --%test(Удаление с не заданным параметром id кошелька приводит к ошибке)
  --%throws(wallet_api_pack.c_error_code_wrong_input_param)
  procedure delete_wallet_with_null_wallet_id_leads_to_error;

  ----- вспомогательные процедуры
  procedure create_wallet_one;--setup
  procedure delete_wallet_one;--cleanup

end;
/

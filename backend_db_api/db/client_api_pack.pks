create or replace package client_api_pack is
  /*
  Автор: Кивилев Д.С.
  Описание: API для сущности "Клиент"
  */

  -- Статусы активности клиента
  c_client_status_active   constant client.is_active%type := 1;
  c_client_status_inactive constant client.is_active%type := 0;

  ---- API

  -- Создание клиента
  function create_client(p_create_dtime client.create_dtime%type
                        ,p_first_name   client.first_name%type
                        ,p_last_name    client.last_name%type
                        ,p_middle_name  client.middle_name%type
                        ,p_email        client.email%type
                        ,p_phone        client.phone%type)
    return client.client_id%type;

  -- Деактивация клиента (soft delete)
  procedure deactivate_client(p_client_id client.client_id%type);


  ---- Триггеры  
  -- Проверка, допустимость изменения клиента
  procedure check_ins_upd_possible;

  -- Проверка, на возможность удалять данные
  procedure check_del_possible;

end;
/

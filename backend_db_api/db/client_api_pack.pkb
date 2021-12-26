create or replace package body client_api_pack is

  g_is_api boolean := false; -- признак, выполняется ли изменение через API

  -- разрешение менять данные
  procedure allow_changes is
  begin
    g_is_api := true;
  end;

  -- запрет менять данные
  procedure disallow_changes is
  begin
    g_is_api := false;
  end;

  procedure try_lock_client_(p_client_id client.client_id%type) is
    v_is_active client.client_id%type;
  begin
    -- пытаемся заблокировать клиента
    select cl.is_active
      into v_is_active
      from client cl
     where cl.client_id = p_client_id
       for update nowait;
  
    -- объект уже неактивен. с ним нельзя работать
    if v_is_active = c_client_status_inactive then
      raise_application_error(common_pack.c_error_code_inactive_object,
                              common_pack.c_error_msg_inactive_object);
    end if;
  
  exception
    when no_data_found then
      -- такой клиент вообще не найден
      raise_application_error(common_pack.c_error_code_object_notfound,
                              common_pack.c_error_msg_object_notfound);
    when common_pack.e_row_locked then
      -- объект не удалось заблокировать
      raise_application_error(common_pack.c_error_code_object_already_locked,
                              common_pack.c_error_msg_object_already_locked);
  end;

  -- Создание клиента
  function create_client(p_create_dtime client.create_dtime%type
                        ,p_first_name   client.first_name%type
                        ,p_last_name    client.last_name%type
                        ,p_middle_name  client.middle_name%type
                        ,p_email        client.email%type
                        ,p_phone        client.phone%type)
    return client.client_id%type is
    v_client_id client.client_id%type;
  begin
    allow_changes();
  
    -- создание клиента
    insert into client
      (client_id
      ,is_active
      ,create_dtime
      ,first_name
      ,last_name
      ,middle_name
      ,email
      ,phone)
    values
      (client_seq.nextval
      ,c_client_status_active
      ,p_create_dtime
      ,p_first_name
      ,p_last_name
      ,p_middle_name
      ,p_email
      ,p_phone)
    returning client_id into v_client_id;
  
    disallow_changes();
  
    return v_client_id;
  
  exception
    when others then
      disallow_changes();
      raise;
  end;

  -- Клиент деактивирован
  procedure deactivate_client(p_client_id client.client_id%type) is
  begin
    if p_client_id is null then
      raise_application_error(common_pack.c_error_code_invalid_input_parameter,
                              common_pack.c_error_msg_empty_object_id);
    end if;
  
    try_lock_client_(p_client_id); -- блокируем клиента
  
    allow_changes();
  
    -- обновление клиента
    update client cl
       set cl.is_active = c_client_status_inactive
     where cl.client_id = p_client_id
       and cl.is_active = c_client_status_active;
  
    disallow_changes();
  
  exception
    when others then
      disallow_changes();
      raise;
  end;

  procedure check_ins_upd_possible is
  begin
    if not g_is_api then
      raise_application_error(common_pack.c_error_code_manual_changes,
                              common_pack.c_error_msg_manual_changes);
    end if;
  end;

  procedure check_del_possible is
  begin
    raise_application_error(common_pack.c_error_code_delete_forbidden,
                            common_pack.c_error_msg_delete_forbidden);
  end;

end;
/

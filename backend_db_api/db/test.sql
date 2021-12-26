----- Примитивная проверка API
-- truncate table client;

-- 1) Создание клиента
declare
  v_client client.client_id%type;  
begin
  v_client := client_api_pack.create_client(p_create_dtime => sysdate - 1/24,
                                p_first_name   => 'Иван',
                                p_last_name    => 'Иванов',
                                p_middle_name  => 'Иванович',
                                p_email        => 'ivan@mail.ru',
                                p_phone        => '+799999999999');

  dbms_output.put_line('New client id: '|| v_client);                                 
  commit;                                
end;
/

select * from client;

-- 2) Тестируем обход API - update
update client c set c.is_active = 0 where c.client_id = 1;


-- 3) Тестируем удаление 
delete client c where c.client_id  = 1;

-- 4) Деактивация клиента
declare
  v_client client.client_id%type := 1;
begin
  client_api_pack.deactivate_client(p_client_id => v_client);
end;
/

select * from client;
rollback;


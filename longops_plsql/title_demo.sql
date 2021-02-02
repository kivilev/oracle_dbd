declare
  v_client_count number := 200; -- количество клиентов
  
  v_sofar     number := 0;
  v_rindex    pls_integer := dbms_application_info.set_session_longops_nohint;
  v_slno      pls_integer;
  v_totalwork number := v_client_count;
  v_obj       pls_integer;
    
  procedure inc_step is -- текущий прогресс
  begin
    v_sofar := v_sofar + 1;
    dbms_application_info.set_session_longops(rindex      => v_rindex,
                                              slno        => v_slno,
                                              op_name     => 'Обновление клиентов',
                                              target      => v_obj,
                                              context     => 0,
                                              sofar       => v_sofar,
                                              totalwork   => v_totalwork,
                                              target_desc => 'клиент',
                                              units       => 'клиентов');
  end;
begin  

  -- делаем v_client_count итераций
  for i in 1..v_client_count loop
    --  ... делаем что-то полезное ...    
    dbms_session.sleep(0.1);-- спим 100 мс
    inc_step();-- отображаем прогресс
  end loop;  

end;
/

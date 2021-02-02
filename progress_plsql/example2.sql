declare
  v_stage_count number := 4; -- количество этапов

  v_sofar     number := 0;
  v_rindex    pls_integer := dbms_application_info.set_session_longops_nohint;
  v_slno      pls_integer;
  v_totalwork number := v_stage_count;
  v_obj       pls_integer;
    
  procedure inc_step is -- текущий прогресс
  begin
    v_sofar := v_sofar + 1;
    dbms_application_info.set_session_longops(rindex      => v_rindex,
                                              slno        => v_slno,
                                              op_name     => 'Поэтапная обработка чего-то',
                                              target      => v_obj,
                                              context     => 0,
                                              sofar       => v_sofar,
                                              totalwork   => v_totalwork,
                                              target_desc => 'этап',
                                              units       => 'этапы');
  end;
begin  
  -- Этап 1   
  dbms_session.sleep(5); -- здесь должна быть какая-то полезная нагрузка
  inc_step();-- отображаем прогресс
  
  -- Этап 2     
  dbms_session.sleep(5); -- здесь должна быть какая-то полезная нагрузка
  inc_step();-- отображаем прогресс
  
  -- Этап 3   
  dbms_session.sleep(5); -- здесь должна быть какая-то полезная нагрузка
  inc_step();-- отображаем прогресс

  -- Этап 4
  dbms_session.sleep(5); -- здесь должна быть какая-то полезная нагрузка
  inc_step();-- отображаем прогресс
  
end;
/


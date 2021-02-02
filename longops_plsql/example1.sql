declare
  v_emp_count number; -- количество клиентов
  
  v_sofar     number := 0;
  v_rindex    pls_integer := dbms_application_info.set_session_longops_nohint;
  v_slno      pls_integer;
  v_obj       pls_integer;
    
  procedure inc_step is -- прогресс
  begin
    v_sofar := v_sofar + 1;
    dbms_application_info.set_session_longops(rindex      => v_rindex,
                                              slno        => v_slno,
                                              op_name     => 'Обработка сотрудников',
                                              target      => v_obj,
                                              context     => 0,
                                              sofar       => v_sofar,
                                              totalwork   => v_emp_count,
                                              target_desc => 'сотрудник',
                                              units       => 'сотрудники');
  end;
begin  
  
  -- получаем общее количество сотрудников
  select count(*) 
    into v_emp_count 
    from employees t;

  -- проходим по всем сотрудникам
  for i in 1..v_emp_count loop
    --  ... делаем что-то полезное ...        
    dbms_session.sleep(0.1);-- спим 100 мс
    
    inc_step();-- отображаем прогресс
  end loop;

end;
/

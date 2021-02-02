declare
  v_stage_count        number := 4; -- всего этапов
  v_stage_current      number := -1; -- текущий этап
  v_stage_rindex       pls_integer := dbms_application_info.set_session_longops_nohint;
  v_stage_slno         pls_integer;
  v_obj                pls_integer;
  v_single_rindex      pls_integer := dbms_application_info.set_session_longops_nohint;
  v_single_current     number;
  v_single_total_work  number;
  v_single_action_name varchar2(200 char);
  v_single_slno        pls_integer;

  procedure stage_progress is -- общий прогресс бар
  begin
    v_stage_current := v_stage_current + 1;
    dbms_application_info.set_session_longops(rindex      => v_stage_rindex,
                                              slno        => v_stage_slno,
                                              op_name     => 'Общий прогресс обработки',
                                              target      => v_obj,
                                              context     => 0,
                                              sofar       => v_stage_current,
                                              totalwork   => v_stage_count,
                                              target_desc => 'этап',
                                              units       => 'этапы');
  end;

  procedure single_progress is -- прогресс бар в самой стадии
  begin
    v_single_current := v_single_current + 1;
    dbms_application_info.set_session_longops(rindex      => v_single_rindex,
                                              slno        => v_single_slno,
                                              op_name     => v_single_action_name,
                                              target      => v_obj,
                                              context     => 0,
                                              sofar       => v_single_current,
                                              totalwork   => v_single_total_work,
                                              target_desc => 'сущность',
                                              units       => 'сущности');
  end;

  procedure init_single_progress
  (
    p_action_name varchar2
   ,p_total_work  number
  ) is
  begin
    v_single_action_name := p_action_name;
    v_single_total_work  := p_total_work;
    v_single_current     := 0;
    v_single_rindex      := dbms_application_info.set_session_longops_nohint;
  end;

begin
  stage_progress(); -- отобразим состояние прогресс бара этапов

  -- Этап 1
  init_single_progress('Сбор клиентов', 100);
  for i in 1 .. 100 loop
    dbms_session.sleep(0.1);
    single_progress();
  end loop;
  stage_progress();

  -- Этап 2     
  init_single_progress('Фильтрация клиентов', 50);
  for i in 1 .. 50 loop
    dbms_session.sleep(0.1);
    single_progress();
  end loop;
  stage_progress();

  -- Этап 3   
  init_single_progress('Отправка email клиентам', 30);
  for i in 1 .. 30 loop
    dbms_session.sleep(0.1);
    single_progress();
  end loop;
  stage_progress();

  -- Этап 4
  init_single_progress('Отправка sms клиентам', 40);
  for i in 1 .. 40 loop
    dbms_session.sleep(0.1);
    single_progress();
  end loop;
  stage_progress();

end;
/

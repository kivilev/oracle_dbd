-------- ПРОФИЛИРОВАНИЕ
begin
  
  -- вкл профилирование
  dbms_hprof.start_profiling(location => 'HPROF_DIR', filename => 'my_report_'||to_char(sysdate,'hh24miss')||'.trc');

  -- выполняем наш код
  main_proc;

  -- выкл профилирование
  dbms_hprof.stop_profiling();

end;
/

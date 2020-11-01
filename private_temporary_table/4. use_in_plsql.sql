------ 4. Использование в PL/SQL

-- так использовать не получится
declare
  v_cnt number;
begin
  create private temporary table ora$ptt_my_tab_ctas
  on commit drop definition
  as select level lvl from dual connect by level <= 10000;

  select count(*) into v_cnt
    from ora$ptt_my_tab_ctas;

end;
/

-- использование только через динамический SQL
declare
  v_cnt number;
begin
  execute immediate '
  create private temporary table ora$ptt_my_tab_ctas
  on commit drop definition
  as select level lvl from dual connect by level <= 10000';

  execute immediate '
  select count(*)
    from ora$ptt_my_tab_ctas' into v_cnt;
  
  dbms_output.put_line('Count: '||v_cnt);

end;
/


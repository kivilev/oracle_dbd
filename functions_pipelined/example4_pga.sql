--------- Пример 4. Использование PGA

-- Получение текущего использования PGA
create or replace function get_session_pga return number as
  v_pga_size number;
begin
  select sum(round(s.value / 1024))
    into v_pga_size
    from v$sesstat  s
        ,v$statname n
   where s.statistic# = n.statistic#
     and sid = sys_context('USERENV', 'SID');
  return v_pga_size;
end;
/

--- тест delay_simple
declare
  p1 number;
  p2 number;
  v_cnt number;
begin
  p1 := get_session_pga();

  select count(1) into v_cnt
    from table(delay_simple(1e6, 0));

  p2 := get_session_pga();

  dbms_output.put_line('PGA usage simple: '||round((p2-p1)/1024,2)||' Kb'); 
end;
/


--- тест delay_pipelined
declare
  p1 number;
  p2 number;
  v_cnt number;
begin
  p1 := get_session_pga();

  select count(1) into v_cnt
    from table(delay_pipelined(1e6, 0));

  p2 := get_session_pga();

  dbms_output.put_line('PGA usage pipelined: '||round((p2-p1)/1024,2)||' Kb'); 
end;
/

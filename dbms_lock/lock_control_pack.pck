create or replace package lock_control_pack is

  -- Author  : D.KIVILEV
  -- Created : 25.04.2020 23:37:39
  -- Purpose : API управления блокировками

  -- получить блокировку
  function allocate_lock(p_lock_name varchar2) return varchar2;

  -- освободить блокировку
  procedure release_lock(p_lock_handle varchar2);

end lock_control_pack;
/
create or replace package body lock_control_pack is
  
  -- получить блокировку
  function allocate_lock(p_lock_name varchar2) return varchar2 is
    v_lockresult number;
    v_lockhandle varchar2(128 char);
    v_timeout    number := 0; -- без ожидания
  begin
    --устанавливаем пользовательскую блокировку
    -- Получаем указатель на блокировку
    dbms_lock.allocate_unique(lockname   => p_lock_name,
                              lockhandle => v_lockhandle);
    -- Запросим блокировку
    v_lockresult := dbms_lock.request(v_lockhandle,
                                      dbms_lock.x_mode,
                                      v_timeout,
                                      release_on_commit => false);
  
    case v_lockresult
      when 0 then
        null;
      when 1 then
        raise_application_error(-20102,
                                'Lock ' || p_lock_name ||
                                ' has already gotten another session! Timeout = ' ||
                                v_timeout);
      else
        raise_application_error(-20102,
                                'Was error while blocking lock ' ||
                                p_lock_name || ' код  = ' || v_lockresult);
    end case;
  
    return v_lockhandle;
  end;

  -- освободить блокировку
  procedure release_lock(p_lock_handle varchar2) is
    v_lockresult number;
  begin
    v_lockresult := dbms_lock.release(p_lock_handle);
  end;

end lock_control_pack;
/

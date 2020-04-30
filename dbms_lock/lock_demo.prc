create or replace procedure lock_demo is
  v_lockname   varchar2(128 char) := 'LOCK$HR$DEMO';-- название блокировки
  v_lockresult number;
  v_lockhandle varchar2(128 char);
  v_timeout    number := 5; -- ожидание, сек
begin
  -- Получаем указатель на блокировку
  dbms_lock.allocate_unique(lockname   => v_lockname,
                            lockhandle => v_lockhandle);
  -- Запросим блокировку
  v_lockresult := dbms_lock.request(v_lockhandle,
                                    lockmode          => dbms_lock.x_mode,
                                    timeout           => v_timeout,
                                    release_on_commit => false);

  case v_lockresult
    when 0 then
      --всё хорошо, идем дальше, блокировку удалось захватить
      dbms_output.put_line('Удалось захватить блокировку :)');
    when 1 then
      raise_application_error(-20102, 'Ресурс ' || v_lockname || ' заблокирован! Таймаут = ' || v_timeout);
    else
      raise_application_error(-20102, 'Ошибка блокировки ресурса ' || v_lockname || ' код  = ' || v_lockresult);
  end case;

  -- ЗДЕСЬ БИЗНЕСОВЫЙ КОД -> просто спим
  dbms_session.sleep(10);

  -- Освободим блокировку
  v_lockresult := dbms_lock.release(v_lockhandle);

exception
  when others then
    -- Освободим блокировку
    v_lockresult := dbms_lock.release(v_lockhandle);
    raise;
end;
/

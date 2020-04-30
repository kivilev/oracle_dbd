--- Какое-то приложение в Oracle, получает блокировку на первого клиента
declare
  v_lock_handle varchar2(128 char);
begin
  v_lock_handle := lock_control_pack.allocate_lock(p_lock_name => 'LOCK$CLIENT$1'); 
end;
/

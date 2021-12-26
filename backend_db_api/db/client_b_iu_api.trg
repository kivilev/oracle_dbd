create or replace trigger client_b_iu_api
  before insert or update on client
begin
  client_api_pack.check_ins_upd_possible(); -- проверяем выполняется ли изменение через API
end;
/

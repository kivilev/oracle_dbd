create or replace package common_pack is

  -- Author  : D.KIVILEV
  -- Purpose : Общие объекты

  -- Сообщения ошибок
  c_error_msg_empty_object_id       constant varchar2(100 char) := 'ID объекта не может быть пустым';
  c_error_msg_empty_reason          constant varchar2(100 char) := 'Причина не может быть пустой';
  c_error_msg_delete_forbidden      constant varchar2(100 char) := 'Удаление объекта запрещено';
  c_error_msg_manual_changes        constant varchar2(100 char) := 'Изменения должны выполняться только через API';
  c_error_msg_inactive_object       constant varchar2(100 char) := 'Объект в конечном статусе. Изменения невозможны';
  c_error_msg_object_notfound       constant varchar2(100 char) := 'Объект не найден';
  c_error_msg_object_already_locked constant varchar2(100 char) := 'Объект уже заблокирован';

  -- Коды ошибок
  c_error_code_invalid_input_parameter constant number(10) := -20101;
  c_error_code_delete_forbidden        constant number(10) := -20102;
  c_error_code_manual_changes          constant number(10) := -20103;
  c_error_code_inactive_object         constant number(10) := -20104;
  c_error_code_object_notfound         constant number(10) := -20105;
  c_error_code_object_already_locked   constant number(10) := -20106;

  -- Объекты ошибок
  e_invalid_input_parameter exception;
  pragma exception_init(e_invalid_input_parameter, -20101);
  e_delete_forbidden exception;
  pragma exception_init(e_delete_forbidden, -20102);
  e_manual_changes exception;
  pragma exception_init(e_manual_changes, -20103);
  e_object_notfound exception;
  pragma exception_init(e_object_notfound, -20105);
  e_row_locked exception;
  pragma exception_init(e_row_locked, -00054);
  e_object_already_locked exception;
  pragma exception_init(e_object_already_locked, -20106);

end;
/

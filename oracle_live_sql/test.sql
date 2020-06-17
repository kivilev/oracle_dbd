ообщеdelete from my_employee;
commit;

-- вставка
declare
  v_new_id my_employee.id%type;
begin
  v_new_id := my_employee_pack.create_new_employee(p_fio    => 'Иванов Игорь Викторович',
                                                   p_salary => 10000);
  dbms_output.put_line('New employee id: ' || v_new_id);

  v_new_id := my_employee_pack.create_new_employee(p_fio    => 'Петров Петр Петрович',
                                                   p_salary => 999);
  dbms_output.put_line('New employee id: ' || v_new_id);
end;
/

  select * from my_employee;

-- изменение
declare
  v_upd_id my_employee.id%type;
begin
  select t.id into v_upd_id from my_employee t where rownum <= 1;

  my_employee_pack.change_employee(p_id     => v_upd_id,
                                   p_fio    => null,
                                   p_salary => 5555);
  dbms_output.put_line('Upd employee id: ' || v_upd_id);
end;
/

  select * from my_employee;


-- удаление
declare
  v_del_id my_employee.id%type;
begin
  select t.id into v_del_id from my_employee t where rownum <= 1;

  my_employee_pack.remove_employee(p_id => v_del_id);
  dbms_output.put_line('Del employee id: ' || v_del_id);
end;
/

  select * from my_employee;

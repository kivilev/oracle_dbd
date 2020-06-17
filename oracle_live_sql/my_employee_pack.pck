create or replace package my_employee_pack is

  -- Author  : D.KIVILEV
  -- Created : 07.06.2020 17:48:06
  -- Purpose : API для работы с таблицей my_employee

  -- создание
  function create_new_employee
  (
    p_fio    my_employee.fio%type
   ,p_salary my_employee.salary%type
  ) return my_employee.id%type;

  -- изменение
  procedure change_employee
  (
    p_id     my_employee.id%type
   ,p_fio    my_employee.fio%type
   ,p_salary my_employee.salary%type
  );

  -- удаление
  procedure remove_employee(p_id my_employee.id%type);

end my_employee_pack;
/
create or replace package body my_employee_pack is

  -- создание
  function create_new_employee
  (
    p_fio    my_employee.fio%type
   ,p_salary my_employee.salary%type
  ) return my_employee.id%type is
    v_id my_employee.id%type;
  begin
    insert into my_employee
      (id
      ,fio
      ,salary)
    values
      (my_employee_seq.nextval
      ,p_fio
      ,p_salary)
    returning id into v_id;
    return v_id;
  end;

  -- изменение
  procedure change_employee
  (
    p_id     my_employee.id%type
   ,p_fio    my_employee.fio%type
   ,p_salary my_employee.salary%type
  ) is
  begin
    update my_employee t
       set t.fio    = nvl(p_fio, t.fio)
          ,t.salary = nvl(p_salary, t.salary)
     where t.id = p_id;
  end;

  -- удаление
  procedure remove_employee(p_id my_employee.id%type) is
  begin
    delete from my_employee t where t.id = p_id;
  end;

end my_employee_pack;
/

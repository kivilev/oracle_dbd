-- процедура, управления остатком на складе
create or replace procedure change_rest
(
  p_product_id warehouse.product_id%type
 ,p_count      warehouse.rest%type
) is
  v_current_rest warehouse.rest%type; -- текуший остаток
begin
  -- получаем текущий остаток
  select t.rest
    into v_current_rest
    from warehouse t
   where t.product_id = p_product_id;
  
  -- выведем остаток в буфер вывода
  dbms_output.put_line('Current rest = '||v_current_rest);

  -- проверяем остаток на складе
  if v_current_rest - p_count < 0
  then
    raise_application_error(-20100, 'Остатка на складке не хватает!');
  end if;

  -- обновляем на новое значение
  update warehouse t
     set t.rest = t.rest - p_count
   where t.product_id = p_product_id;

end;
/

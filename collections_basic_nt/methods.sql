-- ************* Встроенные методы коллекций ****************
declare
  v_schema_coll t_numbers := t_numbers(1, 5, 3, 900);
begin
  -- Количество элементов
  dbms_output.put_line('Schema Coll count: '|| v_schema_coll.count()); 
  
  -- Удаление элементов
  v_schema_coll.delete(1); -- удаляем 1й элемент
  -- v_schema_coll.delete(); -- все элементы
  
  -- проверка на существование элемента
  if not v_schema_coll.exists(1) then
    dbms_output.put_line('1-го элемента нет'); 
  end if;
  
  -- Получить индекс первого элемента
  dbms_output.put_line('First index: '||v_schema_coll.first);  
  
  -- Получить индекс последнего элемента
  dbms_output.put_line('Last index: '||v_schema_coll.last);
  
  -- Расширить коллекцию на 1 элемент
  v_schema_coll.extend();
  v_schema_coll(v_schema_coll.last) := 100;
  dbms_output.put_line('Last element value: '||v_schema_coll(v_schema_coll.last));
  
  -- Получить индекс следующего и предыдущего элемента. Параметр - индекс от которого получаем
  dbms_output.put_line('Prev Last index: '||v_schema_coll.next(v_schema_coll.first));
  dbms_output.put_line('Prev Last index: '||v_schema_coll.prior(v_schema_coll.last));
  
  -- пустая ли коллеция
  if v_schema_coll is not empty then
    dbms_output.put_line('Коллекция не пустая'); 
  end if;
  
end;
/

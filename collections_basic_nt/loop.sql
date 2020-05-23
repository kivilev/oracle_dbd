-- ******************** Проход по коллекции **********

---- 1. Часто употребляемый способ для коллекций без "дырок"
declare
  type t_local_numbers is table of number(30);
  v_local_coll t_local_numbers := t_local_numbers(1, 5, 3, 100, 101);
begin
  dbms_output.put_line('Local Coll Count: '|| v_local_coll.count());

  -- обязательно проверяем на пустоту и инициализацию
  if v_local_coll is not empty then
    -- в цикле проходим по элементам. В коллекции не должно быть "дырок"
    for i in v_local_coll.first..v_local_coll.last loop
      dbms_output.put_line('Coll['||i||']= '||v_local_coll(i)); 
    end loop;
  end if; 
end;
/

---- 2. Редко употребляемый способ для коллекций с "дырками"
--      в основном используется для ассоциативных массивов
declare
  type t_local_numbers is table of number(30);
  v_local_coll t_local_numbers := t_local_numbers(1, 5, 3, 100, 101);
  v_index      pls_integer;
begin
  v_local_coll.delete(2);-- удаляем "5". теперь на 2м индекс "дырка"

  dbms_output.put_line('Local Coll Count: '|| v_local_coll.count());

  -- обязательно проверяем на пустоту и инициализацию
  if v_local_coll is not empty then
    -- в цикле проходим по элементам получая следующий индекс элемента. В коллекции могут быть "дырки"
    v_index := v_local_coll.first;
    loop
      exit when v_index is null;-- проверяем на конец коллекции
      dbms_output.put_line('Coll['||v_index||']= '||v_local_coll(v_index));
      v_index := v_local_coll.next(v_index);-- получаем инекс след элемента
    end loop;
    
  end if; 
end;
/

--********** Стэк вызова **********

------ 1. Пакет dbms_utility
declare

  procedure p3 
  is
  begin
    raise NO_DATA_FOUND;
  end;

  procedure p2
  is
  begin
    p3();
  end;

begin
  p2();
exception
  when others then
    dbms_output.put_line(dbms_utility.format_error_backtrace);
    dbms_output.put_line('=======================');
    dbms_output.put_line(dbms_utility.format_call_stack); 
    dbms_output.put_line('=======================');
    dbms_output.put_line(dbms_utility.format_error_stack);     
end;
/


------ 2. utl_call_stack
create or replace procedure level_3 -- уровень 3
is
begin
  -- имя модуля
  dbms_output.put_line( 'Current module: '|| utl_call_stack.owner(1) || '.' ||
  utl_call_stack.concatenate_subprogram (utl_call_stack.subprogram (1))) ;

  -- стек вызова. по-старинке
  dbms_output.put_line(dbms_utility.format_call_stack);

end;
/

create or replace procedure level_2 -- уровень 2.
is
begin
   level_3(); 
end;
/

create or replace procedure level_1 -- уровен 1.
is
begin
   level_2(); 
end;
/

-- все вызываем
begin
  level_1(); 
end;
/


----- СОЗДАНИЕ ТЕСТОВОГО ПРИМЕРА

create or replace procedure my_proc1
is
begin
  dbms_session.sleep(1); 
end;
/

create or replace procedure my_proc2
is
begin
 null;
end;
/

create or replace function my_func1 return number
is
begin
  dbms_session.sleep(5);
  return 1; 
end;
/

create or replace procedure my_proc3
is
  v_cnt number;
begin
  select count(my_func1()) into v_cnt 
    from dual;
  dbms_session.sleep(3); 
end;
/

create or replace procedure my_proc41
is
begin
  dbms_session.sleep(10);
end;
/

create or replace procedure my_proc4
is
begin
  my_proc41();
end;
/

create or replace procedure my_proc5
is
begin
  dbms_session.sleep(5); 
end;
/

create or replace procedure main_proc
is
begin
  my_proc1();
  my_proc2();
  my_proc3();
  my_proc4();
  my_proc5();   
end;
/

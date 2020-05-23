-- *********** Создание коллекций ***********

---- 1) На уровне схемы
create or replace type t_numbers is table of number(30);
/

---- 2) На уровне пакета
create or replace package my_pack is

  type t_pack_numbers is table of number(30);
  
  procedure my_proc;

end;
/

create or replace package body my_pack is
  
  procedure my_proc
  is
    v_my_coll t_pack_numbers := t_pack_numbers();
  begin
    null;
  end;

end;
/

---- 3) На уровне pl/sql-блока
declare
  type t_local_numbers is table of number(30);
  v_my_coll t_local_numbers;
begin
  null;
end;
/


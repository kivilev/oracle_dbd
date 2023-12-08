-- Create table
create table MYTAB1
(
  n1 NUMBER not null,
  v2 VARCHAR2(100)
)
result_cache(mode force);


insert into MYTAB1
select level, level from dual connect by level <=10;

create or replace function sleepp return number is
begin
  dbms_session.sleep(1); 
  return 1;
end;
/

select v2, sleepp()
  from MYTAB1


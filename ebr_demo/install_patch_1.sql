---- Упрощенное демо патча (demodb_dba). Патч номер "1".

---- 1. Создаем эдицию, в которую будем ставить наши объекты
create edition edition_p1;
comment on edition edition_p1 is 'Install patch #1';
grant use on edition edition_p1 to hr_ebr;

---- 2. Переключаем сессиию установшика в эту эдицию
alter session set edition = edition_p1;

---- 3. Катим изменения 
alter session set current_schema = hr_ebr;

create or replace function hr_ebr_func return varchar2 is
begin
  return 'HR_EBR_FUNC. Version 2. ' || sys_context('userenv', 'current_edition_name');
end;
/

create or replace procedure hr_ebr_proc is
begin
  dbms_output.put_line('HR_EBR_PROC. ' || sys_context('userenv', 'current_edition_name'));
end;
/

---- 4. Делаем эту эдицию по умолчанию на уровне БД
alter database default edition = edition_p1;


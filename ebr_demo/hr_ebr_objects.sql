---- Объекты для схемы HR_EBR

-- функция, на которой будем тестировать
create or replace function hr_ebr_func return varchar2 is
begin
  return 'HR_EBR_FUNC. Version 1. ' || sys_context('userenv', 'current_edition_name');
end;
/

-- эмуляция задержки
create or replace function sleep(p_sec number) return number
is
begin
  dbms_session.sleep(p_sec);
  return 1;
end;
/

-- имитируем нагрузку\блокировку
select hr_ebr_func() --  <--
      ,sleep(10)
  from dual
connect by level <= 100;

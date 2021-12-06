--текущая эдиция сессии
select sys_context('userenv', 'current_edition_name') from dual;

--дефолтная эдиция БД
select property_value 
  from database_properties 
 where property_name = 'DEFAULT_EDITION';
  
--эдиции по порядку, от новых к старым
select t.edition_name, t.parent_edition_name
      ,tt.created
      ,tt.last_ddl_time
      ,tt.timestamp
      ,level      
  from dba_editions t
  join dba_objects tt on t.edition_name = tt.object_name
 start with t.edition_name = 'ora$base'
connect by prior t.edition_name = t.parent_edition_name
 order by level desc;

-- сессии - эдиции
select do.object_name, vs.sid, vs.serial#, vs.machine, vs.*
  from v$session vs
  join dba_objects do
    on vs.session_edition_id = do.object_id

-- переключить сессиию в другую эдицию
alter session set edition = edition_p2;

-- сделать эдицию по умолчанию на уровне БД
alter database default edition = edition_p1;

-- разрешение на использование 
grant use on edition ora$base to demodb_dba;

-- грохнуть эдицию
drop edition edition_p4;

-- гранты на создание, удаление эдиций
grant create any edition, drop any edition to demodb_dba;

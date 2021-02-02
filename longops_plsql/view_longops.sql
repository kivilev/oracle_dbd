-- смотреть longops для всех сессий
select round((sofar/totalwork)*100,2)||'%' progress, t.sofar, t.totalwork, t.opname, t.start_time, t.time_remaining, t.last_update_time, t.message
  from v$session_longops t 
  order by t.last_update_time desc;

-- смотреть longops для конкретной сессии
select round((sofar/totalwork)*100,2)||'%' progress, t.sofar, t.totalwork, t.opname, t.start_time, t.time_remaining, t.last_update_time, t.message
  from v$session_longops t 
where t.sid = :sid and t.serial# = :serial#;

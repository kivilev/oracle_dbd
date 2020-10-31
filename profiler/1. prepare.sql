-------- ПОДГОТОВКА СИСТЕМЫ

-- Создаем директорию
create or replace directory hprof_dir as '/opt/oracle/diag/hprofiler';

-- Даем права на неё
grant read, write on directory hprof_dir to hr;

-- Даем грант на пакет с профилировщиком
grant execute on sys.dbms_hprof to hr;


------ Пример 5. Отправка email

-- коллекция для чтения данных
create or replace type t_csv_line is object (
  id number(30),
  to_email varchar2(100 char),
  to_name varchar2(100 char)
);
/
create or replace type t_csv_lines is table of t_csv_line;
/

-- коллекция для обогащения данных
create or replace type t_enrich_line is object (
  id number(30),  
  to_email varchar2(100 char),
  to_name varchar2(100 char),
  from_email varchar2(100 char),
  from_name varchar2(100 char),
  text      varchar2(100 char)
);
/
create or replace type t_enrich_lines is table of t_enrich_line;
/

----- pipelined-фукнции
create or replace function read_data_from_file_pipe return t_csv_lines
pipelined
is
begin
  dbms_output.put_line('-- read_data_from_file_pipe.start: '||to_char(systimestamp,'hh24:mi:ss.ff6')); 
  
  for i in 1..300 loop
    dbms_session.sleep(0.01);
    pipe row(t_csv_line(i, 'to_email'||i||'@mail.ru', 'FullNameTo'||i)); -- читаем из файла и отдаем
  end loop;

  dbms_output.put_line('-- read_data_from_file_pipe.end: '||to_char(systimestamp,'hh24:mi:ss.ff6'));     
end;
/
--
create or replace function enrich_data_pipe return t_enrich_lines
pipelined
is
begin
  dbms_output.put_line('-- enrich_data_pipe.start: '||to_char(systimestamp,'hh24:mi:ss.ff6')); 
 
  for line_csv in (select * from read_data_from_file_pipe()) loop
    dbms_session.sleep(0.01);
    pipe row(t_enrich_line(line_csv.id , line_csv.to_email, line_csv.to_name, 'org@org.com','Email bot', 'Some Text'));--обогашаем и отдаем
  end loop;
  
  dbms_output.put_line('-- enrich_data_pipe.end: '||to_char(systimestamp,'hh24:mi:ss.ff6'));   
end;
/
--
create or replace procedure send_email_for_pipe
is
begin
  for line_enrich in (select * from enrich_data_pipe()) loop
    dbms_session.sleep(0.01);
    dbms_output.put_line('TimeStamp: '||to_char(systimestamp,'hh24:mi:ss.ff6') ||' => send email to '||line_enrich.to_email);
  end loop;
end;
/

------- standard
create or replace function read_data_from_file return t_csv_lines
is
 v_csv_lines t_csv_lines := t_csv_lines();
begin
  dbms_output.put_line('-- read_data_from_file.start: '||to_char(systimestamp,'hh24:mi:ss.ff6')); 
  
  for i in 1..300 loop
    dbms_session.sleep(0.01);
    v_csv_lines.extend(1);
    v_csv_lines(v_csv_lines.last) := t_csv_line(i, 'to_email'||i||'@mail.ru', 'FullNameTo'||i); -- читаем из файла и отдаем
  end loop;
  
  dbms_output.put_line('-- read_data_from_file.end: '||to_char(systimestamp,'hh24:mi:ss.ff6')); 
  
  return v_csv_lines;
end;
/
--
create or replace function enrich_data return t_enrich_lines
is
 v_enrich_lines t_enrich_lines := t_enrich_lines();
begin
  
  dbms_output.put_line('-- enrich_data.start: '||to_char(systimestamp,'hh24:mi:ss.ff6')); 

  for line_csv in (select * from read_data_from_file()) loop
    dbms_session.sleep(0.01);
    v_enrich_lines.extend(1);
    v_enrich_lines(v_enrich_lines.last) := t_enrich_line(line_csv.id , line_csv.to_email, line_csv.to_name, 'org@org.com','Email bot', 'Some Text');--обогашаем и отдаем
  end loop;
  
  dbms_output.put_line('-- enrich_data.end: '||to_char(systimestamp,'hh24:mi:ss.ff6')); 
  
  return v_enrich_lines;
end;
/
--
create or replace procedure send_email
is
begin
  for line_enrich in (select * from enrich_data()) loop
    dbms_session.sleep(0.01);
    dbms_output.put_line('TimeStamp: '||to_char(systimestamp,'hh24:mi:ss.ff6') ||' => send email to '||line_enrich.to_email);
  end loop;
end;
/

------- вызов 
call send_email(); -- обычные

call send_email_for_pipe(); -- Pipelined


-- Запуск всех тестов во всех пакетах (полный регресс)
select *
  from table(ut.run());

-- Запуск тестов в конкретном пакете
select *
  from table(ut.run('ut_wallet_api_pack'));

-- Запуск тестов в одном с выбором формата отчета
select *
  from table(ut.run(a_reporter => ut_teamcity_reporter()));

-- Формирование html-отчета на покрытие кода тестами
select *
  from ut.run(a_reporter => ut_coverage_html_reporter ());
 

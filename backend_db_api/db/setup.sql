/*
Установочный скрипт

1. Схема должна быть создана. Пример - create_user.sql

*/

prompt create_objects.sql
@@create_objects.sql

prompt common_pack.pks
@@common_pack.pks

prompt client_api_pack.pks
@@client_api_pack.pks

prompt client_api_pack.pkb
@@client_api_pack.pkb

prompt client_b_iu_api.trg
@@client_b_iu_api.trg

prompt client_b_d_restrict.trg
@@client_b_d_restrict.trg

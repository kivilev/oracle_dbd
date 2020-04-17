--==== SESSION 2

-- кейс без ожидания
select * from wallet t where t.wallet_id = 1 for update nowait;

-- кейс с ожиданием 3 сек
select * from wallet t where t.wallet_id = 1 for update wait 3;

-- кейс с бесконечным ожиданием
select * from wallet t where t.wallet_id = 1 for update;


-- пропуск заблокированных строк
select * from wallet t for update skip locked;

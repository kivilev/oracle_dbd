--==== SESSION 1
select * from wallet t where t.wallet_id = 1 for update;

update wallet t 
   set t.balance = 50
 where t.wallet_id = 1;

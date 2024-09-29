execute immediate from 'steps/DB-Setup.sql' using (environment => '{{environment}}', lookerpassword => '{{lookerpassword}}');;
SELECT 'Load raw tables completed.';
execute immediate from 'steps/Load-Raw-Tables.sql' using (environment => '{{environment}}');;

execute immediate from 'steps/Create-DW-Tables.sql' using (environment => '{{environment}}');;
execute immediate from 'steps/Load-DW-Main-Tables.sql' using (environment => '{{environment}}');;
execute immediate from 'steps/Load-DW-Hierachy-Tables.sql' using (environment => '{{environment}}');;
execute immediate from 'steps/Load-Events-From-API-Gateway.sql' using (environment => '{{environment}}');;
execute immediate from 'steps/Load-Serve-Tables.sql' using (environment => '{{environment}}');;

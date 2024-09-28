execute immediate from 'steps/DB-Setup.sql' using (environment => '{{environment}}', lookerpassword => '{{lookerpassword}}');;
execute immediate from 'steps/Load-Raw-Tables.sql' using (environment => '{{environment}}');;

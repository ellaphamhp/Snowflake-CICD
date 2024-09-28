execute immediate from 'steps/DB-Setup.sql' using (environment => '{{environment}}', lookerpassword => '{{lookerpassword}}');;
execute immediate from 'steps/Load-Raw-Employment-By-Industry.sql' using (environment => '{{environment}}');;

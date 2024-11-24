USE DATABASE DATAPROJECT_{{environment}};

--Create external utils to call Lambda utils Get Inflation Rate:
CREATE OR REPLACE EXTERNAL FUNCTION DATAPROJECT_{{environment}}.PUBLIC.GET_EVENT()
    RETURNS VARIANT
    API_INTEGRATION = get_event_api
    AS 'https://ayaac8bic5.execute-api.eu-west-2.amazonaws.com/default/Get_Inflation_Rate';

//Create raw event table
CREATE OR REPLACE TABLE DATAPROJECT_{{environment}}.RAW."trade_events" (
    "dateUtc" TIMESTAMP_LTZ
    ,"isBetterThanExpected" STRING
    ,"name" STRING
    ,"volatility" STRING
);

//Create procedure to call API, then copy result file stored in S3 into table
CREATE OR REPLACE PROCEDURE DATAPROJECT_{{environment}}.PUBLIC.Load_Event()
    RETURNS VARCHAR
    LANGUAGE SQL
    AS
    BEGIN
    LET sql := 'COPY INTO DATAPROJECT_{{environment}}.RAW."trade_events" 
                    FROM (
                        SELECT $1:dateUtc::TIMESTAMP_LTZ
                            , $1:isBetterThanExpected::VARCHAR
                            , $1:name::VARCHAR
                            , $1:volatility::VARCHAR
                        FROM @DATAPROJECT_{{environment}}."PUBLIC"."S3_STAGE_EVENTS"/<date>/trade_event.json
                    )
                    FILE_FORMAT = DATAPROJECT_{{environment}}.PUBLIC.MY_JSON_FORMAT
                    ON_ERROR=ABORT_STATEMENT;';
    sql := REPLACE(sql, '<date>', TO_VARCHAR(CURRENT_DATE(), 'YYYYMMDD'));
    EXECUTE IMMEDIATE (sql);
    RETURN sql;
    END;


//Create Task to Call stored procedures to call API to load data
CREATE OR REPLACE TASK DATAPROJECT_{{environment}}.PUBLIC.LOAD_EVENT
    WAREHOUSE = COMPUTE_WH
    AFTER   DATAPROJECT_{{environment}}.PUBLIC.LOAD_EMPLOYMENT_BY_INDUSTRY
    AS CALL DATAPROJECT_{{environment}}.PUBLIC.LOAD_EVENT();
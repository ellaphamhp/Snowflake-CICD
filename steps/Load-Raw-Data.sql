//CREATE PIPE snowpipe_db.public.mypipe
COPY INTO DATAPROJECT_{{environment}}.RAW."employment_by_industry"
FROM( SELECT t.$1
        ,t.$2
        ,t.$3
        ,t.$4 
        ,t.$5 
        ,t.$6
        ,t.$7
        ,t.$8
        ,t.$9
        ,CURRENT_TIMESTAMP()
        FROM @DATAPROJECT_{{environment}}.PUBLIC.MY_S3_STAGE t
)
FILE_FORMAT = (FORMAT_NAME=DATAPROJECT_{{environment}}.PUBLIC.MY_CSV_FORMAT);

  
//CREATE PIPE to ingest data from S3
COPY INTO DATAPROJECT_{{environment}}.RAW."hourly_earnings_by_industry"
FROM( SELECT t.$1
        ,t.$2
        ,t.$3
        ,t.$4 
        ,t.$5 
        ,t.$6
        ,t.$7
        ,t.$8
        ,t.$9
        ,CURRENT_TIMESTAMP()
        FROM @DATAPROJECT_{{environment}}.PUBLIC.MY_S3_STAGE_HOURLY_EARNINGS t
)
FILE_FORMAT = (FORMAT_NAME=DATAPROJECT_{{environment}}.PUBLIC.MY_CSV_FORMAT);

  
//CREATE PIPE snowpipe_db.public.mypipe
COPY INTO DATAPROJECT_{{environment}}.RAW."weekly_hours_by_industry"
FROM( SELECT t.$1
        ,t.$2
        ,t.$3
        ,t.$4 
        ,t.$5 
        ,t.$6
        ,t.$7
        ,t.$8
        ,t.$9
        ,CURRENT_TIMESTAMP()
        FROM @DATAPROJECT_{{environment}}.PUBLIC.MY_S3_STAGE_WEEKLY_HOURS t
)
FILE_FORMAT = (FORMAT_NAME=DATAPROJECT_{{environment}}.PUBLIC.MY_CSV_FORMAT);
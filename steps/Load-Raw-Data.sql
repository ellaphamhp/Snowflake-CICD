--Redundant script, not used in deployment

USE DATABASE DATAPROJECT_{{environment}};

//employment_by_industry
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

  
//hourly_earnings_by_industry
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

  
//weekly_hours_by_industry
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


//principal_ports
COPY INTO "DATAPROJECT_{{environment}}."RAW"."principal_ports"
    FROM(
    SELECT t.$1
          ,t.$2
          ,t.$3
          ,t.$4
          ,t.$5
          ,t.$6
          ,t.$7
          ,t.$8
          ,t.$9
          ,t.$10
          ,t.$11
          ,t.$12
          ,CURRENT_TIMESTAMP()
          FROM @DATAPROJECT_{{environment}}.PUBLIC.S3_STAGE_PORTS t
    )
    FILE_FORMAT = (FORMAT_NAME=DATAPROJECT_{{environment}}.PUBLIC.MY_CSV_FORMAT);
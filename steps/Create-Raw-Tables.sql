DATAPROJECT_{{environment}}.

//Create raw employment by industry table
CREATE OR REPLACE TABLE DATAPROJECT_{{environment}}.RAW."employment_by_industry" (
  "Seq_no" INT,
  "Hierachy_Level" INT,
  "Period" STRING,
  "Year" INT,
  "Month" INT,
  "SeriesID" STRING,
  "Metric_Name" STRING,
  "Industry_Name" STRING,
  "Metric_Value" FLOAT,
  "Created_Date" TIMESTAMP_LTZ(0));

  
//CREATE PIPE snowpipe_db.public.mypipe
  CREATE OR REPLACE PIPE DATAPROJECT_{{environment}}.public.S3_PIPE
  AUTO_INGEST = TRUE
  AWS_SNS_TOPIC='arn:aws:sns:eu-west-2:899986137183:newdata_us_employment'
  AS
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

  
//Create raw hourly earnings by industry table
CREATE OR REPLACE TABLE DATAPROJECT_{{environment}}.RAW."hourly_earnings_by_industry" (
  "Seq_no" INT,
  "Hierachy_Level" INT,
  "Period" STRING,
  "Year" INT,
  "Month" INT,
  "SeriesID" STRING,
  "Hourly_Earnings" STRING,
  "Industry_Name" STRING,
  "Metric_Value" FLOAT,
  "Created_Date" TIMESTAMP_LTZ(0));

  
//CREATE PIPE to ingest data from S3
  CREATE OR REPLACE PIPE DATAPROJECT_{{environment}}.public.S3_PIPE_HOURLY_EARNINGS
  AUTO_INGEST = TRUE
  AWS_SNS_TOPIC='arn:aws:sns:eu-west-2:899986137183:New_File_Hourly_Earning_By-Industry'
  AS
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

//Create raw weekly hours by industry table
CREATE OR REPLACE TABLE DATAPROJECT_{{environment}}.RAW."weekly_hours_by_industry" (
  "Seq_no" INT,
  "Hierachy_Level" INT,
  "Period" STRING,
  "Year" INT,
  "Month" INT,
  "SeriesID" STRING,
  "Weekly_Hours" STRING,
  "Industry_Name" STRING,
  "Metric_Value" FLOAT,
  "Created_Date" TIMESTAMP_LTZ(0));

  
//CREATE PIPE snowpipe_db.public.mypipe
  CREATE OR REPLACE PIPE DATAPROJECT_{{environment}}.public.S3_PIPE_WEEKLY_HOURS
  AUTO_INGEST = TRUE
  AWS_SNS_TOPIC='arn:aws:sns:eu-west-2:899986137183:New_File_Weekly_Hours_By_Industry'
  AS
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
CREATE DATABASE IF NOT EXISTS DATAPROJECT_{{environment}};
USE DATABASE DATAPROJECT_{{environment}};
USE SCHEMA PUBLIC;

CREATE STORAGE INTEGRATION IF NOT EXISTS aws
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::899986137183:role/snowflake_data_exporter'
  STORAGE_AWS_EXTERNAL_ID= 'WA12632_SFCRole=2_AjCI31/ab03W4RdMW1Ivznna6VI='
  STORAGE_ALLOWED_LOCATIONS = ('*');

-----------------------
-----------------------
////FILE FORMATS

// Creating file format object: csv
CREATE file format IF NOT EXISTS DATAPROJECT_{{environment}}.public.my_csv_format;
ALTER file format DATAPROJECT_{{environment}}.public.my_csv_format SET SKIP_HEADER=1;
ALTER file format DATAPROJECT_{{environment}}.public.my_csv_format SET FIELD_OPTIONALLY_ENCLOSED_BY = '0x22';

// Creating file format object: json
CREATE file format IF NOT EXISTS DATAPROJECT_{{environment}}.public.my_json_format
    TYPE = JSON,
    STRIP_OUTER_ARRAY = TRUE;
--DESC file format DATAPROJECT.public.my_json_format


-----------------------
-----------------------
////STAGES
//Create stage that store my data files: employment by industry tables
CREATE STAGE IF NOT EXISTS my_s3_stage
  URL='s3://dataproject-jun24/usa/labor/industry_employment/us_employment_by_industry.csv/'
    STORAGE_INTEGRATION = aws
    DIRECTORY = (
      ENABLE = true
      AUTO_REFRESH = true
      AWS_SNS_TOPIC = 'arn:aws:sns:eu-west-2:899986137183:newdata_us_employment'
    );
 -- DESC STAGE my_s3_stage

//Create stage that store my data files: hourly earning by industry
CREATE STAGE IF NOT EXISTS my_s3_stage_hourly_earnings
    URL= 's3://dataproject-jun24/usa/labor/industry_employment/us_hourly_earnings_by_industry.csv/'
    STORAGE_INTEGRATION = aws
    DIRECTORY = (
      ENABLE = true
      AUTO_REFRESH = true
      AWS_SNS_TOPIC = 'arn:aws:sns:eu-west-2:899986137183:New_File_Hourly_Earning_By-Industry'
    );
--DESC STAGE my_s3_stage_hourly_earnings

//Create stage that store my data files: weekly hours by industry
CREATE STAGE IF NOT EXISTS my_s3_stage_weekly_hours
    URL= 's3://dataproject-jun24/usa/labor/industry_employment/us_weekly_hours_by_industry.csv/'
    STORAGE_INTEGRATION = aws
    DIRECTORY = (
      ENABLE = true
      AUTO_REFRESH = true
      AWS_SNS_TOPIC = 'arn:aws:sns:eu-west-2:899986137183:New_File_Weekly_Hours_By_Industry'
    );
--DESC STAGE my_s3_stage_weekly_hours

  
//Create stage that store my data files: events tables
CREATE STAGE IF NOT EXISTS s3_stage_events
    URL='s3://dataproject-jun24/events/'
    FILE_FORMAT = (
      TYPE = JSON
    )
    STORAGE_INTEGRATION = aws
    DIRECTORY = (
      ENABLE = true
      AUTO_REFRESH = true
      AWS_SNS_TOPIC = 'arn:aws:sns:eu-west-2:899986137183:new_event'
    );
--DESC STAGE s3_stage_events


//Create stage that store my data files: principal ports
CREATE STAGE IF NOT EXISTS s3_stage_ports
  URL='s3://dataproject-jun24/ports/'
  FILE_FORMAT = DATAPROJECT_{{environment}}.PUBLIC.MY_CSV_FORMAT
  STORAGE_INTEGRATION = aws
  DIRECTORY = (
    ENABLE = true
    AUTO_REFRESH = true
    AWS_SNS_TOPIC = 'arn:aws:sns:eu-west-2:899986137183:new_file_port'
  );
--DESC STAGE s3_stage_ports


////API GATEWAY INTEGRATION
create api integration IF NOT EXISTS get_event_api
    api_provider=aws_api_gateway
    api_aws_role_arn='arn:aws:iam::899986137183:role/snowflake_data_exporter'
    api_allowed_prefixes=('https://ayaac8bic5.execute-api.eu-west-2.amazonaws.com/default')
    enabled=true;

  

////USERS 
//Create Looker User for Visualisation
-- change role to ACCOUNTADMIN
use role ACCOUNTADMIN;

-- create role for looker
create role if not exists looker_role;
grant role looker_role to role SYSADMIN;
    -- Note that we are not making the looker_role a SYSADMIN,
    -- but rather granting users with the SYSADMIN role to modify the looker_role

-- create a user for looker
create user if not exists looker_user
    password = {{lookerpassword}}
    DEFAULT_WAREHOUSE = 'COMPUTE_WH'
    DEFAULT_NAMESPACE = 'DATAPROJECT'
    default_role = looker_role;
grant role looker_role to user looker_user;

-- change role
use role ACCOUNTADMIN;

CREATE SCHEMA IF NOT EXISTS DATAPROJECT_{{environment}}.RAW;
CREATE SCHEMA IF NOT EXISTS DATAPROJECT_{{environment}}.DW;
CREATE SCHEMA IF NOT EXISTS DATAPROJECT_{{environment}}.SERVE;

-- grant read only database access (repeat for all database/schemas)
grant usage on warehouse compute_wh to role public;
grant usage on warehouse compute_wh to role looker_role;
grant usage on database DATAPROJECT_{{environment}} to role looker_role;
grant usage on schema DATAPROJECT_{{environment}}.DW to role looker_role;
grant usage on schema DATAPROJECT_{{environment}}.SERVE to role looker_role;
-- rerun the following any time a table is added to the schema
grant select on all tables in schema DATAPROJECT_{{environment}}.dw  to role looker_role;
grant select on all tables in schema DATAPROJECT_{{environment}}.SERVE  to role looker_role;
-- or
grant select on future tables in schema DATAPROJECT_{{environment}}.DW  to role looker_role;
grant select on future tables in schema DATAPROJECT_{{environment}}.SERVE  to role looker_role;
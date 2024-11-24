USE DATABASE DATAPROJECT_{{environment}};
ALTER SESSION SET TIMEZONE='UTC';

//Create Hierachy Table

CREATE OR REPLACE VIEW DATAPROJECT_{{environment}}.DW.Hierachies
AS
(
    WITH cte AS
        (   
            SELECT     
                "SeriesID"
                ,"Industry_Name" 
                ,"Hierachy_Level"
                ,CASE WHEN "Hierachy_Level" > 1 THEN LEFT("SeriesID",4) ELSE NULL END as "Level_2_ID_1"
            FROM DATAPROJECT_{{environment}}.RAW."employment_by_industry"
            UNION
            SELECT     
                "SeriesID"
                ,"Industry_Name" 
                ,"Hierachy_Level"
                ,CASE WHEN "Hierachy_Level" > 1 THEN LEFT("SeriesID",4) ELSE NULL END as "Level_2_ID_1"
            FROM DATAPROJECT_{{environment}}.RAW."hourly_earnings_by_industry"
            UNION
            SELECT     
                "SeriesID"
                ,"Industry_Name" 
                ,"Hierachy_Level"
                ,CASE WHEN "Hierachy_Level" > 1 THEN LEFT("SeriesID",4) ELSE NULL END as "Level_2_ID_1"
            FROM DATAPROJECT_{{environment}}.RAW."weekly_hours_by_industry"
        )
    SELECT DISTINCT
            "SeriesID"
            ,"Industry_Name"
            ,"Hierachy_Level"
            ,CURRENT_TIMESTAMP(0) as "Created_Date"
    ,CASE WHEN ("Level_2_ID_1" = 'CEU5' OR "Level_2_ID_1" = 'CEU6') THEN LEFT("SeriesID",5) ELSE "Level_2_ID_1" END AS "Level_2_ID"
    FROM cte
);


//Level_4_Hierachies table
CREATE OR REPLACE TABLE DATAPROJECT_{{environment}}.DW.Hierachies_L4 AS
SELECT DISTINCT
    "SeriesID"
    ,"Industry_Name"
    ,"Level_2_ID"
    ,"Created_Date"
FROM DATAPROJECT_{{environment}}.DW.Hierachies
WHERE "Hierachy_Level" = 4
ORDER BY "SeriesID";


//Level_2_Hierachies table
CREATE OR REPLACE TABLE DATAPROJECT_{{environment}}.DW.Hierachies_L2 AS
SELECT DISTINCT
    "Level_2_ID"
    ,"Industry_Name"
    ,"Created_Date"
FROM DATAPROJECT_{{environment}}.DW.Hierachies
WHERE "Hierachy_Level" = 2
ORDER BY "Level_2_ID";



//DW data table: employment by industry
CREATE OR REPLACE TABLE DATAPROJECT_{{environment}}.DW.employment_by_industry AS
SELECT 
"Period", "Year", "Month", "SeriesID", "Industry_Name", "Metric_Value", CURRENT_TIMESTAMP(0) as "Created_Date"
FROM DATAPROJECT_{{environment}}.RAW."employment_by_industry"
WHERE "Hierachy_Level" = 4;



//DW data table: hourly earnings by industry
CREATE OR REPLACE TABLE DATAPROJECT_{{environment}}.DW.hourly_earnings_by_industry AS
SELECT 
"Period", "Year", "Month", "SeriesID", "Industry_Name", "Metric_Value" as "Hourly_Earnings", CURRENT_TIMESTAMP(0) as "Created_Date"
FROM DATAPROJECT_{{environment}}.RAW."hourly_earnings_by_industry"
WHERE "Hierachy_Level" = 4;

//DW data table: weekly hours by industry
CREATE OR REPLACE TABLE DATAPROJECT_{{environment}}.DW.weekly_hours_by_industry AS
SELECT 
"Period", "Year", "Month", "SeriesID", "Industry_Name", "Metric_Value" as "Weekly_Hours", CURRENT_TIMESTAMP(0) as "Created_Date"
FROM DATAPROJECT_{{environment}}.RAW."weekly_hours_by_industry"
WHERE "Hierachy_Level" = 4;







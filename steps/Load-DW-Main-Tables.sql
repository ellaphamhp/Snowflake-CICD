/// Load employmen_by_industry table
//Create stream on the view
ALTER TABLE DATAPROJECT_{{environment}}.RAW."employment_by_industry" SET CHANGE_TRACKING = TRUE;

CREATE OR REPLACE STREAM DATAPROJECT_{{environment}}.PUBLIC.Stream_Raw_Table 
    ON TABLE DATAPROJECT_{{environment}}.RAW."employment_by_industry"
        APPEND_ONLY = TRUE;

// Create a task to consume the stream to load data into DW table
CREATE OR REPLACE TASK DATAPROJECT_{{environment}}.PUBLIC.LOAD_EMPLOYMENT_BY_INDUSTRY 
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = '1440 MINUTE'
    WHEN SYSTEM$STREAM_HAS_DATA('Stream_Raw_Table')
    AS 
        INSERT INTO DATAPROJECT.DATAPROJECT_{{environment}}.DW.EMPLOYMENT_BY_INDUSTRY
        ("Period", "Year", "Month", "SeriesID", "Industry_Name", "Metric_Value", "Created_Date")
        SELECT "Period", "Year", "Month", "SeriesID", "Industry_Name", "Metric_Value", CURRENT_TIMESTAMP(0) as "Created_Date"
        FROM DATAPROJECT_{{environment}}.PUBLIC.STREAM_RAW_TABLE
        WHERE "Hierachy_Level" = 4;


------------------------------------
/// Load hourly_earnings_by_industry table
//Create stream on the view
ALTER TABLE DATAPROJECT_{{environment}}.RAW."hourly_earnings_by_industry"SET CHANGE_TRACKING = TRUE;

CREATE OR REPLACE STREAM DATAPROJECT_{{environment}}.PUBLIC.Stream_Raw_Table_Hourly_Earnings 
    ON TABLE DATAPROJECT_{{environment}}.RAW."hourly_earnings_by_industry"
        APPEND_ONLY = TRue;

// Create a task to consume the stream to load data into DW table
CREATE OR REPLACE TASK DATAPROJECT_{{environment}}.PUBLIC.LOAD_HOURLY_EARNINGS_BY_INDUSTRY 
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = '1440 MINUTE'
    WHEN SYSTEM$STREAM_HAS_DATA('Stream_Raw_Table_Hourly_Earnings')
    AS 
        INSERT INTO DATAPROJECT_{{environment}}.DW.HOURLY_EARNINGS_BY_INDUSTRY
        ("Period", "Year", "Month", "SeriesID", "Industry_Name", "Hourly_Earnings", "Created_Date")
        SELECT "Period", "Year", "Month", "SeriesID", "Industry_Name", "Metric_Value", CURRENT_TIMESTAMP(0) as "Created_Date"
        FROM DATAPROJECT_{{environment}}.PUBLIC.Stream_Raw_Table_Hourly_Earnings 
        WHERE "Hierachy_Level" = 4;

------------------------------------
/// Load weekly_hours_by_industry table
//Create stream on the view
ALTER TABLE DATAPROJECT_{{environment}}.RAW."weekly_hours_by_industry" SET CHANGE_TRACKING = TRUE;

CREATE OR REPLACE STREAM DATAPROJECT_{{environment}}.PUBLIC.Stream_Raw_Table_Weekly_Hours 
    ON TABLE DATAPROJECT_{{environment}}.RAW."weekly_hours_by_industry"
        APPEND_ONLY = TRue;

// Create a task to consume the stream to load data into DW table
CREATE OR REPLACE TASK DATAPROJECT_{{environment}}.PUBLIC.LOAD_WEEKLY_HOURS_BY_INDUSTRY 
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = '1440 MINUTE'
    WHEN SYSTEM$STREAM_HAS_DATA('Stream_Raw_Table_Weekly_Hours')
    AS 
        INSERT INTO DATAPROJECT_{{environment}}.DW.WEEKLY_HOURS_BY_INDUSTRY
        ("Period", "Year", "Month", "SeriesID", "Industry_Name", "Weekly_Hours", "Created_Date")
        SELECT "Period", "Year", "Month", "SeriesID", "Industry_Name", "Metric_Value", CURRENT_TIMESTAMP(0) as "Created_Date"
        FROM DATAPROJECT_{{environment}}.PUBLIC.Stream_Raw_Table_Weekly_Hours  
        WHERE "Hierachy_Level" = 4;

----- Task based on Load_Employment_By_Industry
//Auto Update L4 Hierachies table: only append new L4 hierachies
CREATE OR REPLACE TASK DATAPROJECT_{{environment}}.PUBLIC.LOAD_DW_HIERACHIES_L4
    WAREHOUSE = COMPUTE_WH
    AFTER   DATAPROJECT_{{environment}}.PUBLIC.LOAD_EMPLOYMENT_BY_INDUSTRY
    AS 
        MERGE INTO DATAPROJECT_{{environment}}.DW.HIERACHIES_L4 L4
        USING (
            SELECT DISTINCT
                "SeriesID"
                ,"Industry_Name"
                ,"Level_2_ID"
                ,"Created_Date"
            FROM DATAPROJECT_{{environment}}.DW.Hierachies
            WHERE "Hierachy_Level" = 4
        ) V
        ON L4."SeriesID" = V."SeriesID"
        WHEN NOT MATCHED THEN 
            INSERT ("SeriesID","Industry_Name","Level_2_ID","Created_Date") 
            VALUES (
             V."SeriesID"
            ,V."Industry_Name"
            ,V."Level_2_ID"
            ,CURRENT_TIMESTAMP(0));


//Auto Update L2 Hierachies table: only append new L4 hierachies
CREATE OR REPLACE TASK DATAPROJECT_{{environment}}.LOAD_DW_HIERACHIES_L2
    WAREHOUSE = COMPUTE_WH
    AFTER   DATAPROJECT_{{environment}}.PUBLIC.LOAD_EMPLOYMENT_BY_INDUSTRY
    AS 
        MERGE INTO DATAPROJECT_{{environment}}.DW.HIERACHIES_L2 L2
        USING (
            SELECT DISTINCT
            "Level_2_ID"
            ,"Industry_Name"
            ,"Created_Date"
            FROM DATAPROJECT_{{environment}}.DW.Hierachies
            WHERE "Hierachy_Level" = 2
        ) V
        ON L2."Level_2_ID" = V."Level_2_ID"
        WHEN NOT MATCHED THEN 
            INSERT ("Level_2_ID","Industry_Name","Created_Date") 
            VALUES (
             V."Level_2_ID"
            ,V."Industry_Name"
            ,CURRENT_TIMESTAMP(0));

-- -------------------------------------------
-------------------------------------------
  ----- Task based on Load_Hourly_Earnings_By_Industry
//Auto Update L4 Hierachies table: only append new L4 hierachies
CREATE OR REPLACE TASK DATAPROJECT_{{environment}}.PUBLIC.LOAD_DW_HIERACHIES_L4_HOURLY_EARNINGS
    WAREHOUSE = COMPUTE_WH
    AFTER   DATAPROJECT_{{environment}}.PUBLIC.LOAD_HOURLY_EARNINGS_BY_INDUSTRY
    AS 
        MERGE INTO DATAPROJECT_{{environment}}.DW.HIERACHIES_L4 L4
        USING (
            SELECT DISTINCT
                "SeriesID"
                ,"Industry_Name"
                ,"Level_2_ID"
                ,"Created_Date"
            FROM DDATAPROJECT_{{environment}}.DW.Hierachies
            WHERE "Hierachy_Level" = 4
        ) V
        ON L4."SeriesID" = V."SeriesID"
        WHEN NOT MATCHED THEN 
            INSERT ("SeriesID","Industry_Name","Level_2_ID","Created_Date") 
            VALUES (
             V."SeriesID"
            ,V."Industry_Name"
            ,V."Level_2_ID"
            ,CURRENT_TIMESTAMP(0));


//Auto Update L2 Hierachies table: only append new L4 hierachies
CREATE OR REPLACE TASK DATAPROJECT_{{environment}}.PUBLIC.LOAD_DW_HIERACHIES_L2_HOURLY_EARNINGS
    WAREHOUSE = COMPUTE_WH
    AFTER   DDATAPROJECT_{{environment}}.PUBLIC.LOAD_HOURLY_EARNINGS_BY_INDUSTRY
    AS 
        MERGE INTO DATAPROJECT_{{environment}}.DW.HIERACHIES_L2 L2
        USING (
            SELECT DISTINCT
            "Level_2_ID"
            ,"Industry_Name"
            ,"Created_Date"
            FROM DATAPROJECT_{{environment}}.DW.Hierachies
            WHERE "Hierachy_Level" = 2
        ) V
        ON L2."Level_2_ID" = V."Level_2_ID"
        WHEN NOT MATCHED THEN 
            INSERT ("Level_2_ID","Industry_Name","Created_Date") 
            VALUES (
             V."Level_2_ID"
            ,V."Industry_Name"
            ,CURRENT_TIMESTAMP(0));


-------------------------------------------
-------------------------------------------
  ----- Task based on Load_Weekly_Hours_By_Industry
//Auto Update L4 Hierachies table: only append new L4 hierachies
CREATE OR REPLACE TASK DATAPROJECT_{{environment}}.PUBLIC.LOAD_DW_HIERACHIES_L4_WEEKLY_HOURS
    WAREHOUSE = COMPUTE_WH
    AFTER   DATAPROJECT_{{environment}}.PUBLIC.LOAD_WEEKLY_HOURS_BY_INDUSTRY
    AS 
        MERGE INTO DATAPROJECT_{{environment}}.DW.HIERACHIES_L4 L4
        USING (
            SELECT DISTINCT
                "SeriesID"
                ,"Industry_Name"
                ,"Level_2_ID"
                ,"Created_Date"
            FROM DATAPROJECT_{{environment}}.DW.Hierachies
            WHERE "Hierachy_Level" = 4
        ) V
        ON L4."SeriesID" = V."SeriesID"
        WHEN NOT MATCHED THEN 
            INSERT ("SeriesID","Industry_Name","Level_2_ID","Created_Date") 
            VALUES (
             V."SeriesID"
            ,V."Industry_Name"
            ,V."Level_2_ID"
            ,CURRENT_TIMESTAMP(0));


//Auto Update L2 Hierachies table: only append new L4 hierachies
CREATE OR REPLACE TASK DATAPROJECT_{{environment}}.PUBLIC.LOAD_DW_HIERACHIES_L2_WEEKLY_HOURS
    WAREHOUSE = COMPUTE_WH
    AFTER   DATAPROJECT_{{environment}}.PUBLIC.LOAD_WEEKLY_HOURS_BY_INDUSTRY
    AS 
        MERGE INTO DATAPROJECT_{{environment}}.DW.HIERACHIES_L2 L2
        USING (
            SELECT DISTINCT
            "Level_2_ID"
            ,"Industry_Name"
            ,"Created_Date"
            FROM DATAPROJECT_{{environment}}.DW.Hierachies
            WHERE "Hierachy_Level" = 2
        ) V
        ON L2."Level_2_ID" = V."Level_2_ID"
        WHEN NOT MATCHED THEN 
            INSERT ("Level_2_ID","Industry_Name","Created_Date") 
            VALUES (
             V."Level_2_ID"
            ,V."Industry_Name"
            ,CURRENT_TIMESTAMP(0));



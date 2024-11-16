USE DATABASE DATAPROJECT_{{environment}};

--Create materialised view from pivoted DW tables
CREATE OR REPLACE VIEW DATAPROJECT_{{environment}}.SERVE.EMPLOYMENT_STATS_BY_INDUSTRY
AS
WITH TOTAL AS 
            (SELECT E."Period"
                    ,E."Year"
                    ,E."Month"
                    ,E."Industry_Name"
                    ,'Total_Employed' AS "Metric_Name"
                    ,E."Metric_Value" AS "Total_Employed"
            FROM DATAPROJECT_{{environment}}.DW.EMPLOYMENT_BY_INDUSTRY E
            UNION
            SELECT H."Period"
                    ,H."Year"
                    ,H."Month"
                    ,H."Industry_Name"
                    ,'Hourly_Earnings' AS "Metric_Name"
                    ,H."Hourly_Earnings"
            FROM DATAPROJECT_{{environment}}.DW.HOURLY_EARNINGS_BY_INDUSTRY H
            UNION
            SELECT W."Period"
                    ,W."Year"
                    ,W."Month"
                    ,W."Industry_Name"
                    ,'Weekly_Hours' AS "Metric_Name"
                    ,W."Weekly_Hours"
            FROM DATAPROJECT_{{environment}}.DW.WEEKLY_HOURS_BY_INDUSTRY W)
SELECT *
FROM TOTAL
PIVOT (SUM("Total_Employed")
       FOR "Metric_Name" IN ('Hourly_Earnings','Weekly_Hours','Total_Employed'))
ORDER BY 1, 2, 3, 4;


------Change column names and enrich view
CREATE OR REPLACE VIEW DATAPROJECT_{{environment}}.SERVE.EMPLOYMENT_STATS_BY_INDUSTRY_WITH_L2_ID
AS
SELECT DISTINCT
         S."""Period""" AS "Period"
        ,S."""Year""" AS "Year"
        ,S."""Month""" AS "Month"
        ,S."""Industry_Name""" AS "Industry_Name"
        ,S."'Hourly_Earnings'" AS "Hourly_Earnings"
        ,S."'Total_Employed'" AS "Total_Employed"
        ,S."'Weekly_Hours'" AS "Weekly_Hours"
      ,L4."Level_2_ID" AS "Level_2_ID"
FROM DATAPROJECT_{{environment}}.SERVE.EMPLOYMENT_STATS_BY_INDUSTRY S
LEFT JOIN DATAPROJECT_{{environment}}.DW.HIERACHIES_L4 L4 ON S."""Industry_Name""" = L4."Industry_Name"; 




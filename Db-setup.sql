create or replace database DATAPROJECT;

create or replace schema DW;

create or replace TABLE EMPLOYMENT_BY_INDUSTRY (
	"Period" VARCHAR(16777216),
	"Year" NUMBER(38,0),
	"Month" NUMBER(38,0),
	"SeriesID" VARCHAR(16777216),
	"Industry_Name" VARCHAR(16777216),
	"Metric_Value" FLOAT,
	"Created_Date" TIMESTAMP_LTZ(0)
);
This project creates an ETL pipeline to take data from AWS into Snowflake, and processes data in Snowflake to be used for visualisation later in Looker.

Main ETL components: 
- Data Lake: Snowflake's external stages hosted on AWS: these stages store data passed from AWS Data Exchange and AWS API Gateway.
- Ingestion Pipelines: 
  - S3 buckets trigger SNS notifications to Snowflake >>
  - Snowflake copies data from S3 stages into Raw tables >>
  - SnowPipe monitors new data in Raw tables and Snowflake tasks process data into DW tables >>
  - Serve views are updated when DW tables are updated >> 
  - Serve views are refreshed and Looker dashboards taken data from Serve views are therefore refreshed. 
  
In The Folder:
- .Github: workflows/blank.yml: template used by Github Actions to deploy Snowflake database to the specified environment, triggered on push to dev or master branch.
- steps: folder contain deployment SQL scripts
- deploy_pipeline.sql: list of EXECUTE SQL statements to be executed by Github Actions as part of DB deployment
- config.toml: configuration of role and warehouse for Github Actions to use Snowflake
- function: definition of the Lambda function designed to pull data from AWS, triggered by Snowflake via Snowflake's UDF

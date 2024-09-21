USE ROLE ACCOUNTADMIN;

CREATE WAREHOUSE IF NOT EXISTS QUICKSTART_WH WAREHOUSE_SIZE = XSMALL, AUTO_SUSPEND = 300, AUTO_RESUME= TRUE;

-- Separate database for git repository
CREATE DATABASE IF NOT EXISTS QUICKSTART_COMMON;


-- API integration is needed for GitHub integration
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/ellaphamhp') -- INSERT YOUR GITHUB USERNAME HERE
  ENABLED = TRUE;


-- Git repository object is similar to external stage
CREATE OR REPLACE GIT REPOSITORY quickstart_common.public.quickstart_repo
  API_INTEGRATION = git_api_integration
  ORIGIN = 'https://github.com/ellaphamhp/Snowflake-CICD'; -- INSERT URL OF FORKED REPO HERE
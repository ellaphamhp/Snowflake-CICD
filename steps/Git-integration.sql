USE ROLE ACCOUNTADMIN;

-- Separate database for git repository
CREATE DATABASE IF NOT EXISTS INTEGRATION;


-- API integration is needed for GitHub integration
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/ellaphamhp') -- INSERT YOUR GITHUB USERNAME HERE
  ENABLED = TRUE;


-- Git repository object is similar to external stage
CREATE OR REPLACE GIT REPOSITORY integration.public.snowflake_repo
  API_INTEGRATION = git_api_integration
  ORIGIN = 'https://github.com/ellaphamhp/Snowflake-CICD'; -- INSERT URL OF FORKED REPO HERE
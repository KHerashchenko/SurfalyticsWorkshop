-------------------------------------------
-- dbt credentials
-------------------------------------------
USE ROLE securityadmin;
-- dbt roles
CREATE OR REPLACE ROLE dbt_dev_role;
CREATE OR REPLACE ROLE dbt_prod_role;
------------------------------------------- Please replace with your dbt user password
CREATE OR REPLACE USER dbt_user PASSWORD = <your_password>;

GRANT ROLE dbt_dev_role,dbt_prod_role TO USER dbt_user;
GRANT ROLE dbt_dev_role,dbt_prod_role TO ROLE sysadmin;

-------------------------------------------
-- dbt objects
-------------------------------------------
USE ROLE sysadmin;

CREATE OR REPLACE WAREHOUSE dbt_dev_wh  WITH WAREHOUSE_SIZE = 'XSMALL' AUTO_SUSPEND = 60 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 INITIALLY_SUSPENDED = TRUE;
CREATE OR REPLACE WAREHOUSE dbt_prod_wh WITH WAREHOUSE_SIZE = 'XSMALL' AUTO_SUSPEND = 60 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 INITIALLY_SUSPENDED = TRUE;

GRANT ALL ON WAREHOUSE dbt_dev_wh  TO ROLE dbt_dev_role;
GRANT ALL ON WAREHOUSE dbt_prod_wh TO ROLE dbt_prod_role;

CREATE OR REPLACE DATABASE dbt_hol_dev;
USE DATABASE DBT_HOL_DEV;
CREATE OR REPLACE SCHEMA SNAPSHOTS;
GRANT ALL ON DATABASE dbt_hol_dev  TO ROLE dbt_dev_role;
GRANT ALL ON ALL SCHEMAS IN DATABASE dbt_hol_dev   TO ROLE dbt_dev_role;
GRANT ALL ON ALL TABLES IN SCHEMA PUBLIC TO ROLE dbt_dev_role;
GRANT ALL ON ALL TABLES IN SCHEMA SNAPSHOTS TO ROLE dbt_dev_role;

CREATE OR REPLACE DATABASE dbt_hol_prod;
USE DATABASE DBT_HOL_PROD;
CREATE OR REPLACE SCHEMA SNAPSHOTS;
GRANT ALL ON DATABASE dbt_hol_prod TO ROLE dbt_prod_role;
GRANT ALL ON ALL SCHEMAS IN DATABASE dbt_hol_prod  TO ROLE dbt_prod_role;
GRANT ALL ON ALL TABLES IN SCHEMA PUBLIC TO ROLE dbt_prod_role;
GRANT ALL ON ALL TABLES IN SCHEMA SNAPSHOTS TO ROLE dbt_prod_role;

-------------------------------------------
-- fivetran objects
-------------------------------------------

USE ROLE accountadmin;
USE DATABASE pc_fivetran_db;
USE SCHEMA google_calendar_t;
GRANT ALL ON DATABASE pc_fivetran_db TO ROLE dbt_dev_role;
GRANT ALL ON ALL SCHEMAS IN DATABASE pc_fivetran_db TO ROLE dbt_dev_role;
GRANT ALL ON ALL TABLES IN SCHEMA google_calendar_t TO ROLE dbt_dev_role;
GRANT ALL ON DATABASE pc_fivetran_db  TO ROLE dbt_prod_role;
GRANT ALL ON ALL SCHEMAS IN DATABASE pc_fivetran_db TO ROLE dbt_prod_role;
GRANT ALL ON ALL TABLES IN SCHEMA google_calendar_t TO ROLE dbt_prod_role;

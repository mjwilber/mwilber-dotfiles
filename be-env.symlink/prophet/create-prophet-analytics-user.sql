-- PHT-13183:  create a DB user for the Prophet Analytics server
DROP USER IF EXISTS prophet_analytics;
CREATE USER prophet_analytics WITH PASSWORD '0rang3ju1c3';

GRANT edit_role TO prophet_analytics;
-- PHT-17492
-- This patch gives postgres user "prophet_analytics" SUPERUSER
-- capabilities so that it may vacuum database tables. This allows
-- prophet-analytics to better control database performance on
-- complex queries.
ALTER ROLE prophet_analytics WITH SUPERUSER;

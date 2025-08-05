# ClickHouse OP Demo Project

Demonstrating ability to import and query data in Clickhouse, and to connect via
MySQL or HTTP interfaces.

## Usage

1. **Clone or navigate to the project directory**

2. **Copy .env and start the services**
   ```bash
   cp .env.example .env
   docker-compose up -d
   ```

4. **Unzip the CSV**
   ```bash
   unzip clickhouse/user_files/general-payments.zip
   ```

3. **Open the ClickHouse console**
   ```bash
   docker-compose exec clickhouse clickhouse-client
   ```

4. **Create the table**
   ```sql
   CREATE TABLE general_payments ENGINE = MergeTree() ORDER BY tuple() AS SELECT * FROM file('general-payments.csv', CSVWithNames);
   ```

6. **Inspect the table schema**
   ```sql
   DESCRIBE general_payments;
   ```

6. **Try a query or two**
   ```sql
   SELECT * FROM general_payments WHERE Covered_Recipient_NPI = '1346204799'  LIMIT 1;

   SELECT COUNT(*) FROM general_payments WHERE Covered_Recipient_NPI = '1346204799';

7. **Try the PHP scripts to demonstrate PDO and HTTP connections**
   ```bash
   docker-compose exec php-app php /var/www/html/pdo-test.php
   docker-compose exec php-app php /var/www/html/http-test.php
   ```

## ClickHouse Access

### HTTP Interface
```bash
# Test connection
curl "http://localhost:8123/?query=SELECT%201"

# Query with authentication
curl -u app_user:app_password "http://localhost:8123/?query=SELECT%20*%20FROM%20app_db.users"
```

Or use the web app at http://localhost:8123/play


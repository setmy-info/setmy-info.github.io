# PostgreSQL

## Information

## Installation

### CentOS/Rocky Linux

    Probably needs EPEL

```shell
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo dnf -qy module disable postgresql
sudo dnf install -y postgresql16-server
sudo /usr/pgsql-16/bin/postgresql-16-setup initdb
sudo systemctl enable postgresql-16
sudo systemctl start postgresql-16
sudo systemctl status postgresql-16

sudo rpm -i https://ftp.postgresql.org/pub/pgadmin/pgadmin4/yum/pgadmin4-redhat-repo-2-1.noarch.rpm
sudo dnf install pgadmin4

sudo dnf -y install epel-release
sudo dnf -y config-manager --set-enabled PowerTools
sudo dnf config-manager --enable crb
sudo crb enable
sudo dnf -y install postgis34_16
sudo systemctl restart postgresql-16

sudo su - postgres
```

```shell
psql
or
psql -d template1 -U postgres
    \password
    or
    ALTER USER postgres WITH PASSWORD 'supersecretpassword';
    \q
```

In: /var/lib/pgsql/16/data pg_hba.conf

    host    all             all             10.0.0.0/8            scram-sha-256

and postgresql.conf

    listen_addresses = '*'			# what IP address(es) to listen on;

And

    systemctl restart postgresql-16
    systemctl reload postgresql-16

### Fedora

### FreeBSD

```sh
pkg install -y postgresql14-client postgresql14-server
service postgresql oneinitdb
#OR
/usr/local/etc/rc.d/postgresql oneinitdb
sysrc postgresql_class=postgres
sysrc postgresql_enable=YES
```

### OpenIndiana

## Configuration

```sh
cd /var/db/postgres
nano ~/data16/pg_hba.conf
#host    all         all         10.0.0.0/8      md5
```

```sh
cd /var/db/postgres
nano ~/data16/postgresql.conf
#listen_addresses = '*'
```

## Usage, tips and tricks

```sh
su - postgres
psql -d postgres -U postgres

create user has SUPERUSER;
create user dev;
create user devliquibase;
create user test;
create user testliquibase;
create user ci;
create user ciliquibase;
create user prelive;
create user preliveliquibase;
create user live;
create user liveliquibase;

alter user postgres with password 'xxx';
alter user has with password 'xxx';
alter user dev with password 'xxx';
alter user test with password 'xxx';
alter user ci with password 'xxx';
alter user live with password 'xxx';
alter user prelive with password 'xxx';
alter user devliquibase with password 'xxx';
alter user testliquibase with password 'xxx';
alter user ciliquibase with password 'xxx';
alter user liveliquibase with password 'xxx';
alter user preliveliquibase with password 'xxx';

CREATE DATABASE xyz_dev WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE xyz_test WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE xyz_ci WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE xyz_prelive WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE xyz_live WITH TEMPLATE = template0 ENCODING = 'UTF8';

ALTER DATABASE xyz_dev OWNER TO devliquibase;
ALTER DATABASE xyz_test OWNER TO testliquibase;
ALTER DATABASE xyz_ci OWNER TO ciliquibase;
ALTER DATABASE xyz_prelive OWNER TO preliveliquibase;
ALTER DATABASE xyz_live OWNER TO liveliquibase;

GRANT ALL PRIVILEGES ON DATABASE xyz_dev TO devliquibase;
GRANT ALL PRIVILEGES ON DATABASE xyz_test TO testliquibase;
GRANT ALL PRIVILEGES ON DATABASE xyz_ci TO ciliquibase;
GRANT ALL PRIVILEGES ON DATABASE xyz_prelive TO preliveliquibase;
GRANT ALL PRIVILEGES ON DATABASE xyz_live TO liveliquibase;

-- https://www.postgresql.org/docs/current/sql-copy.html
COPY "tablename" (col1, col2) FROM STDIN WITH (FORMAT CSV, DELIMITER ';', QUOTE '"', HEADER true)

DROP TABLE IF EXISTS table1, table2 CASCADE;

DROP SEQUENCE IF EXISTS sequence1, sequence2 CASCADE;

-- Drop DB
DROP DATABASE IF EXISTS xyz_dev WITH (FORCE);

-- Drop chema and create it again as Postgres does it
DROP SCHEMA public CASCADE;
CREATE SCHEMA public AUTHORIZATION pg_database_owner;
GRANT ALL ON SCHEMA public TO pg_database_owner;
GRANT USAGE ON SCHEMA public TO public;
COMMENT ON SCHEMA public IS 'standard public schema';

-- Columns for table
SELECT column_name, data_type, ordinal_position, character_maximum_length, * FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'table_name';

-- Octed data size
SELECT octet_length(bytea_data_column) AS size_in_bytes FROM files;

\ds
\du
```

DB files are located at: /var/lib/pgsql/data

```sh
psql -h dbhost.example.com -p 5432 -U postgres -d template1 -W
psql -h dbhost.example.com -p 5432 -U postgres -d postgres  -W
psql -h dbhost.example.com -p 5432 -U username -d dbname    -W
```

Databases

```sh
\l
\list;
```

Table names and sequence names

```sh
SELECT table_name FROM information_schema.tables WHERE table_schema='ANOTHER_SCHEMA';
\dt

SELECT sequence_schema, sequence_name FROM information_schema.sequences WHERE sequence_schema='ANOTHER_SCHEMA';
\ds
```

DB version and current DB

```sh
SELECT version();
SELECT current_database();
\connect ANOTHERDB;
```

Roles

```sh
SELECT rolname FROM pg_roles;
```

Backup

```sh
sudo su - postgres
pg_dump postgres > postgres.backup
pg_dump -U dev dev > dev.backup
pg_dump -U test test > test.backup
pg_dump -U live live > live.backup
pg_dumpall -U postgres > all.backup

# Remotelly
pg_dump -U username -h remote_ip_address -p remote_port database_name > backup_file

pg_dump -U postgres -h localhost -p 5432 -F c -d database_name -f database_name.pgdump
-- create DB
-- set DB credentials
pg_restore -U postgres -h localhost -p 5432 -d database_name -1 database_name.pgdump

# Specific tables copy
pg_dump -h localhost -p 5432 -U username -d dbname --data-only --table=table1 --table=table2 --inserts > data.sql
psql -h localhost -p 5432 -U username -d dbname -f data.sql
```

Restore

```sh
sudo su - postgres
psql
createdb -T template0 new_database
psql new_database < backup_file
# OR
psql --set ON_ERROR_STOP=on new_database < backup_file
psql -U postgres -f all.backup
```

### JSONB and Geometry

Activate extension for DB

```sql
create
extension postgis; -- as postgres user for particular DB
```

```sql
create table if not exists example
(
    id
    serial
    primary
    key,
    json_column
    jsonb
    not
    null,
    geo_data
    geometry
    not
    null
);
insert into example (json_column, geo_data)
values ('{"firstName":"Imre","lastName":"Tabur"}', ST_GeomFromText('POINT(26.125488 59.531533)', 4326));
insert into example (json_column, geo_data)
values ('{"firstName":"John","lastName":"Doe"}', ST_GeomFromText('POINT(26.125488 59.531533)', 4326));
select *
from example;
select *
from example
where json_column ->>'firstName' = 'Imre';
select *
from example
where json_column ->>'firstName' = 'John';
select *
from example
where json_column ->>'firstName' like 'I%';
select *
from example
where json_column ->>'firstName' like '%m%';
select *
from example
where json_column ->>'firstName' like '%o%';
select *
from example
where json_column ->>'nonExisting' like '%o%';
select *
from example
where json_column ->>'nonExisting' is not null;
```

### PostGIS

A postgres user for PostGIS DB

```
CREATE EXTENSION postgis;
```

With docker

docker-compose.yml

```yaml
version: '0.0.1'
services:
    db:
        image: postgis/postgis
        restart: always
        environment:
            POSTGRES_PASSWORD: 'g6p8'
        volumes:
            - pg-data:/var/lib/postgresql/data
        ports:
            - '5432:5432'
volumes:
    pg-data:
```

Start portainer

```sh
docker compose start
#Or
docker-compose -f docker-compose.yml up
```

Connect with password **g6p8**:

```sh
psql -h localhost -p 5432 -U postgres -d postgres -W
```

Stop portainer

```sh
docker compose stop
```

### Relationships and Structural Coverage

PostgreSQL provides several ways to represent structural relationships between entities, satisfying common modeling
requirements.

#### One-to-One

Usually implemented with a primary key that is also a foreign key, or a unique foreign key.

```sql
CREATE TABLE profile
(
    user_id int PRIMARY KEY REFERENCES users (id),
    bio     text
);
```

#### One-to-Many

The most common relationship, implemented with a foreign key on the "many" side.

```sql
CREATE TABLE post
(
    id      serial PRIMARY KEY,
    user_id int NOT NULL REFERENCES users (id),
    title   text
);
```

#### Many-to-Many

Implemented using a join table (link table) with foreign keys to both entities.

```sql
CREATE TABLE user_roles
(
    user_id int REFERENCES users (id),
    role_id int REFERENCES roles (id),
    PRIMARY KEY (user_id, role_id)
);
```

#### Multi-Parent Relationships

An entity can belong to multiple parents. This is typically implemented with multiple foreign keys (often nullable) and
a constraint to ensure at least one parent exists.

```sql
CREATE TABLE comment (
    id          serial PRIMARY KEY,
    post_id     int REFERENCES post(id),
    page_id     int REFERENCES page(id),
    content     text,
    CONSTRAINT at_least_one_parent CHECK (post_id IS NOT NULL OR page_id IS NOT NULL)
);
```

#### Hierarchy and Self-Referencing

Used for trees and organizational structures where an entity belongs to another entity of the same type.

```sql
CREATE TABLE department
(
    id        serial PRIMARY KEY,
    name      text,
    parent_id int REFERENCES department (id)
);
```

#### Enumerative (Lookup Tables)

Used for global shared entities or fixed sets of values.

```sql
CREATE TABLE status_lookup
(
    code        text PRIMARY KEY,
    description text
);

CREATE TABLE task
(
    id     serial PRIMARY KEY,
    status text REFERENCES status_lookup (code)
);
```

#### Composition and Strong Ownership

Uses `ON DELETE CASCADE` to ensure child entities are deleted with the parent (lifecycle dependency).

```sql
CREATE TABLE order_items
(
    id        serial PRIMARY KEY,
    order_id  int NOT NULL REFERENCES orders (id) ON DELETE CASCADE,
    item_data text
);
```

### Partitioning

PostgreSQL supports table partitioning, which allows a table to be physically divided into smaller pieces. Since
PostgreSQL 10, declarative partitioning is the recommended way to implement this.

#### Types of Partitioning

1. **Range Partitioning**: The table is partitioned into "ranges" defined by a key column or set of columns, with no
   overlap between the ranges of values assigned to different partitions.
2. **List Partitioning**: The table is partitioned by explicitly listing which key value(s) appear in each partition.
3. **Hash Partitioning**: The table is partitioned by specifying a modulus and a remainder for each partition.

#### Examples

**Range Partitioning (by Date)**

```sql
CREATE TABLE measurement
(
    city_id   int  not null,
    logdate   date not null,
    peaktemp  int,
    unitsales int
) PARTITION BY RANGE (logdate);

-- Create partitions
CREATE TABLE measurement_y2024m01 PARTITION OF measurement
    FOR VALUES FROM
(
    '2024-01-01'
) TO
(
    '2024-02-01'
);

CREATE TABLE measurement_y2024m02 PARTITION OF measurement
    FOR VALUES FROM
(
    '2024-02-01'
) TO
(
    '2024-03-01'
);
```

**List Partitioning (by Category)**

```sql
CREATE TABLE products
(
    product_id int  not null,
    category   text not null,
    name       text
) PARTITION BY LIST (category);

-- Create partitions
CREATE TABLE products_electronics PARTITION OF products
    FOR VALUES IN
(
    'electronics',
    'gadgets'
);

CREATE TABLE products_clothing PARTITION OF products
    FOR VALUES IN
(
    'clothing',
    'footwear'
);
```

**Hash Partitioning**

```sql
CREATE TABLE users
(
    user_id  int not null,
    username text
) PARTITION BY HASH (user_id);

-- Create partitions (modulus 4)
CREATE TABLE users_0 PARTITION OF users FOR VALUES WITH
(
    MODULUS
    4,
    REMAINDER
    0
);
CREATE TABLE users_1 PARTITION OF users FOR VALUES WITH
(
    MODULUS
    4,
    REMAINDER
    1
);
CREATE TABLE users_2 PARTITION OF users FOR VALUES WITH
(
    MODULUS
    4,
    REMAINDER
    2
);
CREATE TABLE users_3 PARTITION OF users FOR VALUES WITH
(
    MODULUS
    4,
    REMAINDER
    3
);
```

#### Best Practices and Maintenance

Managing partitions manually is error-prone. In production, you should automate partition creation.

1. **Automated Management with `pg_partman`**:
   `pg_partman` is the most popular extension for managing partitions. It can automatically create future partitions and
   drop/archive old ones.
2. **Scheduled Jobs with `pg_cron`**:
   If you cannot use `pg_partman`, you can use `pg_cron` to run a stored procedure daily that checks for missing future
   partitions and creates them.
3. **Naming Conventions**:
   Use clear naming for partitions (e.g., `table_name_p2024_01`) to make it easier to manage and debug.
4. **Indexes**:
   Indexes must be created on each partition individually or on the parent table (which will automatically create them
   on partitions since PG 11).
5. **Default Partition**:
   Consider creating a `DEFAULT` partition to catch rows that don't fit into any existing partition, but monitor it
   closely as it can impact performance if it grows too large.

```sql
CREATE TABLE measurement_default PARTITION OF measurement DEFAULT;
```

## Control questions

    What is xxxx?

## See also

    [JSONB](http://www.postgresqltutorial.com/postgresql-json/)

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

sudo su - postgres
```

        psql
        or
        psql -d template1 -U postgres
            \password
            or
            ALTER USER postgres WITH PASSWORD 'supersecretpassword';
            \q

In: /var/lib/pgsql/16/data pg_hba.conf and postgresql.conf

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
nano ~/data14/pg_hba.conf
#host    all         all         10.0.0.0/8      md5
```

```sh
cd /var/db/postgres
nano ~/data14/postgresql.conf
#listen_addresses = '*'
```

## Usage, tips and tricks

```sh
su - postgres
psql -d postgres -U postgres

create user has SUPERUSER;
create user dev;
create user devliquibase;
create user testing;
create user testingliquibase;
create user ci;
create user ciliquibase;
create user prelive;
create user preliveliquibase;
create user live;
create user liveliquibase;

alter user postgres with password 'xxx';
alter user has with password 'xxx';
alter user dev with password 'xxx';
alter user testing with password 'xxx';
alter user ci with password 'xxx';
alter user live with password 'xxx';
alter user prelive with password 'xxx';
alter user devliquibase with password 'xxx';
alter user testingliquibase with password 'xxx';
alter user ciliquibase with password 'xxx';
alter user liveliquibase with password 'xxx';
alter user preliveliquibase with password 'xxx';

CREATE DATABASE xyz-dev WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE xyz-test WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE xyz-ci WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE xyz-prelive WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE xyz-live WITH TEMPLATE = template0 ENCODING = 'UTF8';

ALTER DATABASE xyz-dev OWNER TO devliquibase;
ALTER DATABASE xyz-test OWNER TO testingliquibase;
ALTER DATABASE xyz-ci OWNER TO ciliquibase;
ALTER DATABASE xyz-prelive OWNER TO preliveliquibase;
ALTER DATABASE xyz-live OWNER TO liveliquibase;

# TODO : correct rights and correct user
grant all privileges on database dev to devliquibase;
grant all privileges on database testing to testingliquibase;
grant all privileges on database ci to ciliquibase;
grant all privileges on database prelive to preliveliquibase;
grant all privileges on database live to liveliquibase;

COPY "tablename" (col1, col2) FROM STDIN WITH (FORMAT CSV, DELIMITER ',', HEADER true)

DROP TABLE IF EXISTS table1, table2 CASCADE;

DROP SEQUENCE IF EXISTS sequence1, sequence2 CASCADE;

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
pg_dump -U testing testing > test.backup
pg_dump -U live live > live.backup
pg_dumpall -U postgres > all.backup

# Remotelly
pg_dump -U username -h remote_ip_address -p remote_port database_name > backup_file
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
create extension postgis; -- as postgres user for particular DB
```

```sql
create table if not exists example (id serial primary key,	json_column jsonb not null, geo_data geometry not null);
insert into example (json_column, geo_data) values ('{"firstName":"Imre","lastName":"Tabur"}', ST_GeomFromText('POINT(26.125488 59.531533)', 4326));
insert into example (json_column, geo_data) values ('{"firstName":"John","lastName":"Doe"}', ST_GeomFromText('POINT(26.125488 59.531533)', 4326));
select * from example;
select * from example where json_column->>'firstName' = 'Imre';
select * from example where json_column->>'firstName' = 'John';
select * from example where json_column->>'firstName' like 'I%';
select * from example where json_column->>'firstName' like '%m%';
select * from example where json_column->>'firstName' like '%o%';
select * from example where json_column->>'nonExisting' like '%o%';
select * from example where json_column->>'nonExisting' is not null;
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

## Control questions

    What is xxxx?

## See also

    [JSONB](http://www.postgresqltutorial.com/postgresql-json/)

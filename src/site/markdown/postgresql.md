# PostgreSQL

## Information

## Installation

### CentOS

    Probably needs EPEL
    sudo yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
    sudo yum -y install postgresql10 postgresql10-server pgadmin4-web pgadmin4-desktop-common
    sudo /usr/pgsql-10/bin/postgresql-10-setup initdb
    sudo systemctl enable postgresql-10
    sudo systemctl start postgresql-10
    sudo su - postgres
        psql
        or
        psql -d template1 -U postgres
            \password
            or
            ALTER USER postgres WITH PASSWORD 'supersecretpassword';
            CREATE USER test WITH PASSWORD 'testuser';
            CREATE USER dev;
            ALTER USER dev WITH PASSWORD 'xxxxxx';
            CREATE DATABASE testdb encoding 'UTF8';
            ALTER DATABASE testdb OWNER TO test;
            GRANT ALL PRIVILEGES ON DATABASE testdb TO dev;
            \q
    In: /var/lib/pgsql/10/data pg_hba.conf and postgresql.conf
    systemctl restart postgresql-10

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

CREATE DATABASE dev WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE testing WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE ci WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE prelive WITH TEMPLATE = template0 ENCODING = 'UTF8';
CREATE DATABASE live WITH TEMPLATE = template0 ENCODING = 'UTF8';

ALTER DATABASE dev OWNER TO devliquibase;
ALTER DATABASE testing OWNER TO testingliquibase;
ALTER DATABASE ci OWNER TO ciliquibase;
ALTER DATABASE prelive OWNER TO preliveliquibase;
ALTER DATABASE live OWNER TO liveliquibase;

# TODO : correct rights and correct user
grant all privileges on database dev to devliquibase;
grant all privileges on database testing to testingliquibase;
grant all privileges on database ci to ciliquibase;
grant all privileges on database prelive to preliveliquibase;
grant all privileges on database live to liveliquibase;

COPY "tablename" (col1, col2) FROM STDIN WITH (FORMAT CSV, DELIMITER ',', HEADER true)

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

### JSONB

## Control questions

    What is xxxx?

## See also

    [JSONB](http://www.postgresqltutorial.com/postgresql-json/)

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

### OpenIndiana

## Configuration

## Usage, tips and tricks

    DB files are located at: /var/lib/pgsql/data

    psql -h dbhost.example.com -p 5432 -U postgres -d template1 -W
    psql -h test-dbhost.example.com -p 5432 -U testusername -d testdb -W

    SELECT version();
    SELECT current_database();
    \list;
    \connect ANOTHERDB;
    SELECT table_name FROM information_schema.tables WHERE table_schema='ANOTHER_SCHEMA';
    SELECT sequence_schema, sequence_name FROM information_schema.sequences WHERE sequence_schema='ANOTHER_SCHEMA';

### JSONB

## Control questions

    What is xxxx?

## See also

    [JSONB](http://www.postgresqltutorial.com/postgresql-json/)

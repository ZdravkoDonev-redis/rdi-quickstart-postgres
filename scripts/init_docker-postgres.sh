#!/bin/bash

set -e

PGDATA=/var/lib/postgresql/data

echo "wal_level = logical" >> $PGDATA/postgresql.conf
echo "local   all             all                                     trust" > $PGDATA/pg_hba.conf
echo "local   replication     all                                     trust" >> $PGDATA/pg_hba.conf
echo "host    all             all             0.0.0.0/0            trust" >> $PGDATA/pg_hba.conf
echo "host    replication             all             0.0.0.0/0            trust" >> $PGDATA/pg_hba.conf

psql -U postgres postgres -f ~/chinook_create.sql
psql -U postgres chinook -f ~/Chinook_PostgreSql.sql
psql -U postgres chinook -f ~/create_debezium_user.sql

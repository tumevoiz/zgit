#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER zgit;
	CREATE DATABASE zgit_dev;
	GRANT ALL PRIVILEGES ON DATABASE zgit_dev TO zgit;
EOSQL
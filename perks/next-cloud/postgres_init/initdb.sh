#!/usr/bin/env bash
psql "postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST/$POSTGRES_DB?sslmode=disable" <<-EOSQL

create database nextcloud;

create user nextcloud with password 'nextcloud';

grant all privileges on database nextcloud to nextcloud;

EOSQL

#!/bin/bash
set -e

mv /var/lib/postgresql/custom_ca.crt /var/lib/postgresql/data
mv /var/lib/postgresql/custom_ca.crl /var/lib/postgresql/data
mv /var/lib/postgresql/server.crt /var/lib/postgresql/data
mv /var/lib/postgresql/server.key /var/lib/postgresql/data
mv /var/lib/postgresql/pg_hba.conf /var/lib/postgresql/data
mv /var/lib/postgresql/postgresql.conf /var/lib/postgresql/data

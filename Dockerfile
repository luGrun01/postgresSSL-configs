FROM postgres:13-alpine

# COPY ./certs/out/postgresdb.key /var/lib/postgresql
# COPY ./certs/out/postgresdb.crt /var/lib/postgresql
# COPY ./certs/out/myCA.crt /var/lib/postgresql
# COPY ./certs/out/myCA.crl /var/lib/postgresql
# RUN chown 0:70 /var/lib/postgresql/postgresdb.key && chmod 640 /var/lib/postgresql/postgresdb.key
# RUN chown 0:70 /var/lib/postgresql/postgresdb.crt && chmod 640 /var/lib/postgresql/postgresdb.crt
# RUN chown 0:70 /var/lib/postgresql/myCA.crt && chmod 640 /var/lib/postgresql/myCA.crt
# RUN chown 0:70 /var/lib/postgresql/myCA.crl && chmod 640 /var/lib/postgresql/myCA.crl

COPY ./ca/root.crt /var/lib/postgresql
COPY ./ca/server.crt /var/lib/postgresql
COPY ./ca/server.key /var/lib/postgresql
COPY ./postgres_conf/pg_hba.conf /var/lib/postgresql
COPY ./postgres_conf/postgresql.conf /var/lib/postgresql

COPY ./mv_configs.sh /docker-entrypoint-initdb.d
RUN chmod 777 /docker-entrypoint-initdb.d/mv_configs.sh

RUN chown 0:70 /var/lib/postgresql/server.key && chmod 640 /var/lib/postgresql/server.key
RUN chown 0:70 /var/lib/postgresql/server.crt && chmod 640 /var/lib/postgresql/server.crt
RUN chown 0:70 /var/lib/postgresql/root.crt && chmod 640 /var/lib/postgresql/root.crt


ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "postgres" ]

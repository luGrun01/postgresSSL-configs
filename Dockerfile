FROM postgres:13-alpine

COPY ./out/server.crt /var/lib/postgresql
COPY ./out/server.key /var/lib/postgresql

COPY ./out/custom_ca.crt /var/lib/postgresql
COPY ./out/custom_ca.crl /var/lib/postgresql

RUN chown 0:70 /var/lib/postgresql/server.key && chmod 640 /var/lib/postgresql/server.key
RUN chown 0:70 /var/lib/postgresql/server.crt && chmod 640 /var/lib/postgresql/server.crt
RUN chown 0:70 /var/lib/postgresql/custom_ca.crt && chmod 640 /var/lib/postgresql/custom_ca.crt
RUN chown 0:70 /var/lib/postgresql/custom_ca.crl && chmod 640 /var/lib/postgresql/custom_ca.crl

COPY ./postgres_conf/pg_hba.conf /var/lib/postgresql
COPY ./postgres_conf/postgresql.conf /var/lib/postgresql

COPY ./mv_configs.sh /docker-entrypoint-initdb.d
RUN chmod 777 /docker-entrypoint-initdb.d/mv_configs.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "postgres" ]

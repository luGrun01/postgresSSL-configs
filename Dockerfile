FROM postgres:13-alpine

RUN apk add openssl

COPY ./out/server.crt /var/lib/postgresql
COPY ./out/server.key /var/lib/postgresql

COPY ./out/root.crt /var/lib/postgresql

RUN chown 0:70 /var/lib/postgresql/server.key && chmod 640 /var/lib/postgresql/server.key
RUN chown 0:70 /var/lib/postgresql/server.crt && chmod 640 /var/lib/postgresql/server.crt
RUN chown 0:70 /var/lib/postgresql/root.crt && chmod 640 /var/lib/postgresql/root.crt

COPY ./postgres_conf/pg_hba.conf /var/lib/postgresql
COPY ./postgres_conf/postgresql.conf /var/lib/postgresql

COPY ./mv_configs.sh /docker-entrypoint-initdb.d
RUN chmod 777 /docker-entrypoint-initdb.d/mv_configs.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "postgres" ]

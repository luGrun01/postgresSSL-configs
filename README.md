# Generate certificates

self signed
```
# create self signed certificate
openssl req -new -nodes -text -out server.csr -keyout server.key -subj "/CN=localhost"
openssl x509 -req -in server.csr -text -days 365 -CAkey server.key -signkey server.key -CAcreateserial -out server.crt
# use it as root
cp server.crt root.crt
# verify signature
openssl verify -CAfile root.crt server.crt

# client certificate/key
openssl req -new -nodes -text -out client.csr -keyout client.key -subj "/CN=client"
openssl x509 -req -in client.csr -text -days 365 -CA root.crt -CAkey server.key -CAcreateserial  -out client.crt
# verify signature
openssl verify -CAfile root.crt client.crt
# change key permission from client
chmod 600 client.key
```

test signatures
```
    openssl verify -CAfile root.crt server.crt
    openssl verify -CAfile root.crt client.crt
```

Run docker compose up

test if ssl is enabled
```
    docker exec -it postgresSSL su postgres
    psql -U postgres -p 5432 -h localhost
    select * from pg_stat_ssl;
```

test if certs are working inside container
```
    docker exec -it postgresSSL openssl verify -CAfile /var/lib/postgresql/data/root.crt /var/lib/postgresql/data/server.crt
```

Should return a table with ssl t

teardown to reset keys/certs:
```
rm -rf data
docker compose down -v
docker compose build --no-cache
docker compose up
```

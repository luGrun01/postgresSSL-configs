# Generate certificates

self signed
```
openssl req -new -nodes -text -out server.csr -keyout server.key -subj "/CN=localhost" # create original server certificate
openssl x509 -req -in server.csr -text -days 3650 -extfile /etc/ssl/openssl.cnf -signkey server.key -out server.crt # self sign it
cp server.csr root.csr # make a copy to be root.crt

openssl x509 -req -in server.csr -text -days 365 -CA root.crt -CAkey server.key -CAcreateserial -out server.crt

# client certificate/key
openssl req -new -nodes -text -out client.csr -keyout client.key -subj "/CN=client"
openssl x509 -req -in client.csr -text -days 365 -CA root.crt -CAkey server.key -CAcreateserial  -out client.crt
```

test signatures
```
openssl verify -CAfile root.crt server.crt
openssl verify -CAfile root.crt client.crt
```

test if ssl is enabled
```
    su postgres
    psql -U postgres -p 5432 -h localhost
    select * from pg_stat_ssl;
```

Should return a table with ssl t


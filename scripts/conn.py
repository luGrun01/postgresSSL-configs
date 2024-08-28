import ssl
import pg8000.native
import pg8000

ssl_context = ssl.create_default_context(cafile='./out/root.crt')
ssl_context.load_cert_chain(certfile='./out/client.crt', keyfile='./out/client.key')


con = pg8000.native.Connection(user='postgres', password='password',
                               ssl_context=ssl_context, port='5432', host='localhost')

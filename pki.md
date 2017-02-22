# PKI

Here are various useful commands for managing pki.

## Copy Private Key to Server

Copy the centos.pem private key to centos user on server named p1.
<pre>
$ ssh-copy-id -i centos.pem centos@p1
</pre>

You'll be prompted for centos's password; after this you'll be able to ssh without a password.

## Get Certificate from Server
Sometimes you need to export the certificate from a server so you can add it as a trusted server.

<pre>
openssl s_client -connect a1:7443 -showcerts < /dev/null 2>/dev/null | openssl x509 -outform PEM > A1_7443.crt

openssl s_client -connect a2:6443 -showcerts < /dev/null 2>/dev/null | openssl x509 -outform PEM > A2_6443.crt

openssl s_client -connect a3:6443 -showcerts < /dev/null 2>/dev/null | openssl x509 -outform PEM > A3_6443.crt

openssl s_client -connect ags105dj.westus.cloudapp.azure.com:443 -showcerts < /dev/null 2>/dev/null | openssl x509 -outform PEM > ags105dj.westus.cloudapp.azure.com.crt
</pre>

Of course you can do this from the browser; but in my case I needed them so I could import them into trust store for ArcGIS Server.


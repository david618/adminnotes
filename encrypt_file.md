# Encrypt using OpenSSL

Encrypt "somefile" using password "somepassword"

<pre>
$ openssl aes-256-cbc -a -salt  -in somefile -out somefile.enc -pass pass:somepassword
</pre>

Decrypt the file

<pre>
$ openssl aes-256-cbc -a -d  -in somefile.enc -out somefile -pass pass:somepassword
</pre>


#curl
The curl command is used to access a web server.

## Download a file

<pre>
$ curl -O http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.41/bin/apache-tomcat-8.0.41-deployer.tar.gz
</pre>

The file is given the name "apache-tomcat-8.0.41-deployer.tar.gz".


## Call URL that includes &

Put the & in single quotes.

$ curl 192.168.56.1:9999/websats/satfootprints?f=geojson'&'nums=25544

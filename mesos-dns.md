# mesos-dns

## Using DIG 

From any agent you can get the IP of a task.  

For example task "taskmanager" running in group "trinity".

<pre>
$ dig +noall +answer taskmanager.trinity.marathon.mesos
taskmanager.trinity.marathon.mesos. 60 IN A	172.17.2.4
</pre>

You can get the ports using this command.

<pre>
$ dig +noall +answer _taskmanager.trinity._tcp.marathon.mesos SRV
_taskmanager.trinity._tcp.marathon.mesos. 60 IN	SRV 0 0 28541 taskmanager.trinity-51nmf-s2.marathon.mesos.
_taskmanager.trinity._tcp.marathon.mesos. 60 IN	SRV 0 0 28542 taskmanager.trinity-51nmf-s2.marathon.mesos.
</pre>


### Using Curl

<pre>
curl -v http://m1/mesos_dns/v1/enumerate 
</pre>
Returns a error; because access requires authentication.

You can retrieve the token
<pre>
curl -X POST -k -H 'Content-Type: application/json' -d '{"uid":"admin","password":"YOUR PASSWORD"}' https://m1/acs/api/v1/auth/login
</pre>

Cut and paste token into next command replacing {token}.

<pre>
curl -X GET -k -H "Authorization:token={token}"  http://m1/mesos_dns/v1/enumerate
</pre>

## References

Mesosphere [mesos-dns help](https://docs.mesosphere.com/1.9/networking/mesos-dns/service-naming/)

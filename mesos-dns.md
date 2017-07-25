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


## Using Curl

There are some help pages [here](https://github.com/mesosphere/mesos-dns/blob/master/docs/docs/http.md)

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

## Using Python

You'll need to install python-dig 

<pre>
sudo yum -y install python-dns
</pre>

<pre>
>>> import dns.resolver
>>> answers = dns.resolver.query('taskmanager.trinity.marathon.mesos', 'A')
>>> answers[0].address
'172.17.2.4'
>>> answers = dns.resolver.query('_taskmanager.trinity._tcp.marathon.mesos', 'SRV')
>>> answers[0].port
28542
>>> for ans in answers:
...     print ans.port
... 
28542
28541
</pre>


## Frameworks (e.g. Kafka)

Deployed Kafka with name "hub-hub01"

<pre>
$ dig +noall +answer hub-hub01.marathon.mesos
hub-hub01.marathon.mesos. 60	IN	A	172.17.2.4

$ dig +noall +answer _hub-hub01._tcp.marathon.mesos SRV
_hub-hub01._tcp.marathon.mesos.	60 IN	SRV	0 0 11398 hub-hub01-hoyw4-s4.marathon.mesos.

$ dig +noall +answer kafka-0-broker.hub-hub01.mesos
kafka-0-broker.hub-hub01.mesos.	60 IN	A	172.17.2.5

$ dig +noall +answer _kafka-0-broker._tcp.hub-hub01.mesos SRV
_kafka-0-broker._tcp.hub-hub01.mesos. 60 IN SRV	0 0 1025 kafka-0-broker-fy7re-s2.hub-hub01.mesos.
</pre>


Deployed Elastic with name "sats-sat01"

<pre>
$ dig +noall +answer sats-sat01.marathon.mesos
sats-sat01.marathon.mesos. 60	IN	A	172.17.2.8

$ dig +noall +answer _sats-sat01._tcp.marathon.mesos SRV
_sats-sat01._tcp.marathon.mesos. 60 IN	SRV	0 0 6679 sats-sat01-ugj8c-s1.marathon.mesos.

$ dig +noall +answer data-0-node.sats-sat01.mesos
data-0-node.sats-sat01.mesos. 60 IN	A	172.17.2.8

$ dig +noall +answer _data-0-node._tcp.sats-sat01.mesos SRV
_data-0-node._tcp.sats-sat01.mesos. 60 IN SRV	0 0 1025 data-0-node-dpzep-s1.sats-sat01.mesos.
_data-0-node._tcp.sats-sat01.mesos. 60 IN SRV	0 0 1026 data-0-node-dpzep-s1.sats-sat01.mesos.

$ dig +noall +answer _ingest-0-node._tcp.sats-sat01.mesos SRV
_ingest-0-node._tcp.sats-sat01.mesos. 60 IN SRV	0 0 1027 ingest-0-node-sjfq4-s1.sats-sat01.mesos.
_ingest-0-node._tcp.sats-sat01.mesos. 60 IN SRV	0 0 1028 ingest-0-node-sjfq4-s1.sats-sat01.mesos.

$ dig +noall +answer _master-0-node._tcp.sats-sat01.mesos SRV
_master-0-node._tcp.sats-sat01.mesos. 60 IN SRV	0 0 9300 master-0-node-jgtxj-s3.sats-sat01.mesos.
_master-0-node._tcp.sats-sat01.mesos. 60 IN SRV	0 0 1026 master-0-node-jgtxj-s3.sats-sat01.mesos.

</pre>

## References

Mesosphere [mesos-dns help](https://docs.mesosphere.com/1.9/networking/mesos-dns/service-naming/)

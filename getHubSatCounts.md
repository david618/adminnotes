# Measure Counts on HUB and SAT

Created this bash script to collect counts on a Kafka topic and Elasticsearch Index.  This script needs you to know the broker ip and port and elasticsearch ip and port.  

getcount.sh
<pre>
#!/bin/bash

kafkats=$(date +%s)
kafkacnt=$(/home/azureuser/kafka_2.11-0.10.0.1/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list 172.17.2.4:9382 --topic websats-in --time -1 | cut -d ':' -f 3)

elasticts=$(date +%s)
elasticcnt=$(curl -s http://172.17.2.6:9200/websats/websats/_count | jq .count)

echo ${kafkats},${kafkacnt},${elasticts},${elasticcnt}
</pre>


This script gathers info and creates getcounts.sh 
creategetcounts.sh
<pre>
#!/bin/bash
hubname="hub01"
echo -n "What is the hub name (${hubname}): "
read INP
if [ ! -z "${INP}" ]; then
hubname=${INP}
fi

satname="sat01"
echo -n "What is the sat name (${satname}): "
read INP
if [ ! -z "${INP}" ]; then
satname=${INP}
fi

topic="websats-in"
echo -n "What is the sit name (${topic}): "
read INP
if [ ! -z "${INP}" ]; then
topic=${INP}
fi

datasetname="websats"
echo -n "What is the datasetname (${datasetname}): "
read INP
if [ ! -z "${INP}" ]; then
datasetname=${INP}
fi

echo "Creating getcounts.sh"

hubip=$(curl -s http://m1:8080/v2/apps/${hubname} | jq .app.tasks[0].ipAddresses[0].ipAddress | tr -d '"')
hubport=$(curl -s http://m1:8080/v2/apps/${hubname} | jq .app.tasks[0].ports[1])
broker=$(curl -s ${hubip}:${hubport}/v1/connection | jq .address[0] | tr -d '"')
satip=$(curl -s http://m1:8080/v2/apps/sattasks/${satname}/apps/sat | jq '.app.tasks[0].ipAddresses[0].ipAddress' | tr -d '"')
satport=$(curl -s http://m1:8080/v2/apps/sattasks/${satname}/apps/sat | jq '.app.tasks[0].ports[0]')
elasticsearch=$(curl -s ${satip}:${satport}/v1/tasks | jq .[0].http_address | tr -d '"')
echo "broker=$broker"
echo "elsticsearch=${elasticsearch}"

cat > getcounts.sh << EOL
#!/bin/bash

kafkats=\$(date +%s)
kafkacnt=\$(~/kafka_2.11-0.10.0.1/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list ${broker} --topic ${topic} --time -1 | cut -d ':' -f 3)

elasticts=\$(date +%s)
elasticcnt=\$(curl -s http://${elasticsearch}/${datasetname}/${datasetname}/_count | jq .count)

echo \${1},\${kafkats},\${kafkacnt},\${elasticts},\${elasticcnt}
EOL

echo "If successful; then run 'bash getcounts.sh'"
echo "You can optionally add a quoted message to prepend to the results (e.g. \"Start Count\""
</pre>

# Prerequisites

The script needs jq and java
<pre>
# yum install epel-release
# yum install jq
# yum install java-1.8.0-openjdk
</pre>

You'll also need to get put a copy of Kafka in your home directory.

Copied up to the server.

<pre>
$ scp -i azureuser Downloads/kafka_2.11-0.10.0.1.tgz  azureuser@13.64.155.47:.

$ tar xvzf kafka_2.11-0.10.0.1.tgz
$ cd kafka_2.11-0.10.0.1/bin/

./kafka-topics.sh --zookeeper m1:2181/dcos-service-hub01 --list
__consumer_offsets
satellite-in
websats-in
</pre>

# Background for Script Development

## Get Hub Info

<pre>
$ curl -s http://m1:8080/v2/apps/hub01 | jq .app.tasks[0]

{
  "ipAddresses": [
    {
      "ipAddress": "172.17.2.7",
      "protocol": "IPv4"
    }
  ],
  "stagedAt": "2017-03-10T15:00:49.640Z",
  "state": "TASK_RUNNING",
  "ports": [
    27794,
    27795
  ],
  "startedAt": "2017-03-10T15:01:07.254Z",
  "version": "2017-03-10T15:00:49.547Z",
  "id": "hub01.5922c108-05a2-11e7-89d6-428ef76f76d7",
  "appId": "/hub01",
  "slaveId": "785c1be9-65b7-45c2-9d7d-c9b5662d1e30-S2",
  "host": "172.17.2.7",
  "healthCheckResults": [
    {
      "alive": true,
      "consecutiveFailures": 0,
      "firstSuccess": "2017-03-10T15:01:24.717Z",
      "lastFailure": null,
      "lastSuccess": "2017-03-10T20:14:07.164Z",
      "lastFailureCause": null,
      "instanceId": "hub01.marathon-5922c108-05a2-11e7-89d6-428ef76f76d7"
    }
  ]
}
</pre>

Using the ipAddresses and second port 14338. 

<pre>
$ curl -s 172.17.2.7:27795/v1/connection | jq .
{
  "address": [
    "172.17.2.4:9382"
  ],
  "zookeeper": "master.mesos:2181/dcos-service-hub01",
  "dns": [
    "broker-0.hub01.mesos:9382"
  ],
  "vip": "broker.hub01.l4lb.thisdcos.directory:9092"
}
</pre>

Using the broker info you can now get a count on a topic.

<pre>
./kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list 10.10.16.11:9370 --topic websats-in --time -1
websats-in:0:132681
</pre>

## Getting Elasticsearch Info

Getting the SAT info.

<pre>
$ curl -s http://m1:8080/v2/apps/sattasks/sat01/apps/sat | jq . 

$ curl -s http://m1:8080/v2/apps/sattasks/sat01/apps/sat | jq .app.tasks

[
  {
    "ipAddresses": [
      {
        "ipAddress": "172.17.2.5",
        "protocol": "IPv4"
      }
    ],
    "stagedAt": "2017-03-10T15:02:00.892Z",
    "state": "TASK_RUNNING",
    "ports": [
      31100
    ],
    "startedAt": "2017-03-10T15:02:24.624Z",
    "version": "2017-03-10T15:02:00.769Z",
    "id": "sattasks_sat01_apps_sat.839b1959-05a2-11e7-89d6-428ef76f76d7",
    "appId": "/sattasks/sat01/apps/sat",
    "slaveId": "785c1be9-65b7-45c2-9d7d-c9b5662d1e30-S3",
    "host": "172.17.2.5",
    "healthCheckResults": [
      {
        "alive": true,
        "consecutiveFailures": 0,
        "firstSuccess": "2017-03-10T15:02:36.143Z",
        "lastFailure": null,
        "lastSuccess": "2017-03-10T16:16:08.863Z",
        "lastFailureCause": null,
        "instanceId": "sattasks_sat01_apps_sat.marathon-839b1959-05a2-11e7-89d6-428ef76f76d7"
      }
    ]
  }
]
</pre>

Using IP and port for SAT

<pre>
$ curl -s http://172.17.2.5:31100/v1/tasks | jq .

[
  {
    "id": "elasticsearch_172.17.2.6_20170310T150228.228Z",
    "state": "TASK_RUNNING",
    "name": "sat01-node",
    "version": "1.0.1",
    "started_at": "2017-03-10T15:02:28.275Z",
    "http_address": "172.17.2.6:9200",
    "transport_address": "172.17.2.6:9300",
    "hostname": "172.17.2.6"
  }
]
</pre>

Now you can call Elasticsearch

<pre>
$ curl http://172.17.2.6:9200

curl http://172.17.2.6:9200/_aliases | jq .
{
  ".monitoring-es-2-2017.03.10": {
    "aliases": {}
  },
  ".monitoring-data-2": {
    "aliases": {}
  },
  "b044ea93-cea5-4616-892c-939004e6406e_20170310": {
    "aliases": {
      "satellites": {}
    }
  },
  "c114a861-b798-4bf2-b732-e52525723c55": {
    "aliases": {
      "websats": {}
    }
  },
  "b044ea93-cea5-4616-892c-939004e6406e": {
    "aliases": {
      "satellites": {}
    }
  },
  "c114a861-b798-4bf2-b732-e52525723c55_20170310": {
    "aliases": {
      "websats": {}
    }
  }
}
</pre>

To get just a count.

<pre>
curl http://172.17.2.6:9200/websats/websats/_count; echo
25344
</pre>

## Created a script to get counts (getcount.sh)

<pre>
#!/bin/bash

kafkats=$(date +%s)
kafkacnt=$(/home/azureuser/kafka_2.11-0.10.0.1/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list 172.17.2.4:9382 --topic websats-in --time -1 | cut -d ':' -f 3)

elasticts=$(date +%s)
elasticcnt=$(curl -s http://172.17.2.6:9200/websats/websats/_count | jq .count)

echo ${kafkats},${kafkacnt},${elasticts},${elasticcnt}
</pre>

Calling this script I can get counts before starting the sit; while sit is running, and sit was stopped.   

Copied and pasted the results to a Spreadsheet; then cacluated rates..

The script at the top is my attempt to automate the process.

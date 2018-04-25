# statsd

Installation and configuration of [statsd](https://github.com/etsy/statsd/)

## Installation

```
yum -y install epel-release
yum -y install statsd
yum -y install graphite-api
yum -y install python-carbon
```

Overview
- statsd: listens for staticstics and sends aggregates to pluggable backend (Graphite)
- graphite-api (port 8888); Alternative to Graphite-web without built-in dashboard
- python-carbon: Component of Graphic; retrieves metrics and stores them

In the default configuration statsd flushes every 10 seconds and carbon-cache samples every 60 seconds. With this configuration stats from counters are frequently reported as 0.  

Change flush Interval of statsd.  The flushInterval is specified in ms; therefore, 60000 ms is 60 seconds.

```
vi /etc/statsd/config.js

{
  graphitePort: 2003
, graphiteHost: "localhost"
, port: 8125
, backends: [ "./backends/graphite" ]
, flushInterval: 60000
}

```

## Start Service



```
systemctl start statsd
systemctl start graphite-api
systemctl start carbon-cache
```



## Sending Metrics to Statsd

[Metric Types](https://github.com/etsy/statsd/blob/master/docs/metric_types.md)

These include counting and gauges.

Install some support tools for interacting via command line.
```
yum -y install nc
yum -y install jq
```

Create a Gauge and Counter

```
echo  "some.metric.gauge:300|g" | nc -w 1 -u a3 8125
echo  "some.metric.counter:600|c" | nc -w 1 -u a3 8125
```



## Graphite-API

[Graphite-API Docuemntation](http://graphite-api.readthedocs.io/en/latest/api.html)

```
curl localhost:8888/metrics/find -d "query=stats.gauges.some.metric*" | jq
[
  {
    "text": "metric",
    "expandable": 1,
    "leaf": 0,
    "id": "stats.gauges.some.metric",
    "allowChildren": 1
  }
]

curl localhost:8888/metrics/find -d "query=stats.some.metric*" | jq
[
  {
    "text": "metric",
    "expandable": 1,
    "leaf": 0,
    "id": "stats.some.metric",
    "allowChildren": 1
  }
]
```

Retrieve Metrics
```
curl localhost:8888/render -d "target=stats.gauges.some.metric.gauge&format=json" | jq

curl localhost:8888/render -d "target=stats.some.metric.counter&format=json" | jq
```

Returns an array of values.  The Counter is returned as a rate; for example.  Sending 600 one time the rate will be 10/s based on the sampleing rate of one sample a minute.

The gauge value will be whatever was set (e.g. 300).

## Sending Counts 

The follwing command will send value 6,000 every 10 seconds to the counter.   

(while true; do echo  "some.metric.counter:6000|c" | nc -w 1 -u a3 8125; sleep 10; date +%s; done)

Over a period of one minute the counter is incremented by 36,000.  The rate per second would be 36,000/60 or 600.

After a minute or two you'll see values of 600 returned in json from query
```
curl localhost:8888/render -d "target=stats.some.metric.counter&format=json" | jq
```



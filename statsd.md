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


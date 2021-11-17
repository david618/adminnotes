# Example Elastic Calls

## Get Cluster Info

<pre>
curl -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200
</pre>

## Change Shard Allocation

```
curl -s -X PUT "localhost:9200/_cluster/settings" -H 'Content-Type: application/json' -d'{"persistent": {"cluster.routing.allocation.node_concurrent_incoming_recoveries": 10}}'
```

```
curl -s -X PUT "localhost:9200/_cluster/settings" -H 'Content-Type: application/json' -d'{"persistent": {"cluster.routing.allocation.node_initial_primaries_recoveries": 10}}'
```

These can also be done using transient instead of persistent.  Lasts until next restart. 

The default value is 4.  This change seems to allow shards to allocate faster; probably at the cost of additional cpu/mem.  

```
curl localhost:9200/_cluster/settings?pretty
{
  "persistent" : {
    "cluster" : {
      "routing" : {
        "allocation" : {
          "node_concurrent_incoming_recoveries" : "10"
        }
      }
    },
    "slm" : {
      "retention_schedule" : "0 30 1 * * ?"
    }
  },
  "transient" : { }
}
```


## Insert a GeoPoint

<pre>
curl -XPUT -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/test/points/1?pretty -H 'Content-Type: application/json' -d'
{
  "text": "Geo-point as an object",
  "location": { 
    "lat": 41.12,
    "lon": -71.34
  }
}
'
</pre>

## Query Point
<pre>
curl -XGET -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/test/points/1
</pre>

# Query Indices and Aliases
<pre>
curl -XGET -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/_cat/indices

curl -XGET -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/_aliases?pretty
</pre>

## Index Info
<pre>
curl -XGET -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/planes2?pretty
</pre>

## Type Info
<pre>
curl -XGET -u elastic:changeme data.sats-bds-datastc-dd43-46ea-8bc1-e86a8d707022_20170612/planes2/AVydcY4UjmJqBPnObnEE?pretty

{
  "_index" : "2eb29bcc-dd43-46ea-8bc1-e86a8d707022_20170612",
  "_type" : "planes2",
  "_id" : "AVydcY4UjmJqBPnObnEE",
  "_version" : 1,
  "found" : true,
  "_source" : {
    "---geo_hash---" : "39.63001,50.31538",
    "location" : "Ghedi Air Base -> Pulau Pangkor Airport",
    "timestamp" : 1497149266534,
    "secstodep" : -1,
    "---timestamp---" : 1497290083586,
    "objectid" : 211251712,
    "globalid" : "{EA0EF464-8ECA-494F-8A4C-C1BD91E6B63C}",
    "dist" : 6384.87,
    "id" : 77538,
    "lon" : 50.31538,
    "routeid" : 7539,
    "bearing" : 86.82,
    "lat" : 39.63001,
    "speed" : 195.09,
    "geom" : "39.63001,50.31538"
  }
}
</pre>

## Show Mapping

<pre>
curl -XGET -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.dc-dd43-46ea-8bc1-e86a8d707022_20170612/planes2/_mapping?pretty
{
  "2eb29bcc-dd43-46ea-8bc1-e86a8d707022_20170612" : {
    "mappings" : {
      "planes2" : {
        "properties" : {
          "---geo_hash---" : {
            "type" : "esri_geo_hash",
            "hashes" : [
              {
                "lods" : 30,
                "style" : "square",
                "sr" : "102100"
              },
              {
                "lods" : 30,
                "style" : "flatTriangle",
                "sr" : "102100"
              },
              {
                "lods" : 30,
                "style" : "pointyTriangle",
                "sr" : "102100"
              }
            ]
          },
          "---timestamp---" : {
            "type" : "date",
            "store" : true,
            "format" : "epoch_millis"
          },
          "bearing" : {
            "type" : "double",
            "store" : true
          },
          "dist" : {
            "type" : "double",
            "store" : true
          },
          "geom" : {
            "type" : "geo_point",
            "store" : true
          },
          "globalid" : {
            "type" : "keyword",
            "store" : true,
            "fields" : {
              "analyzed" : {
                "type" : "text"
              }
            }
          },
          "id" : {
            "type" : "integer",
            "store" : true
          },
          "lat" : {
            "type" : "double",
            "store" : true
          },
          "location" : {
            "type" : "keyword",
            "store" : true,
            "fields" : {
              "analyzed" : {
                "type" : "text"
              }
            }
          },
          "lon" : {
            "type" : "double",
            "store" : true
          },
          "objectid" : {
            "type" : "long",
            "store" : true
          },
          "routeid" : {
            "type" : "integer",
            "store" : true
          },
          "secstodep" : {
            "type" : "integer",
            "store" : true
          },
          "speed" : {
            "type" : "double",
            "store" : true
          },
          "timestamp" : {
            "type" : "long",
            "store" : true
          }
        }
      }
    }
  }
}



curl -XPUT -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/test2?pretty -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "point2": {
      "properties": {
        "location": {
          "type": "geo_point"
        }
      }
    }
  }
}
'
</pre>

## Add Point at 90 Lat

<pre>
curl -XPUT -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/test2/point2/1?pretty -H 'Content-Type: application/json' -d'
{
  "text": "Geo-point as an object",
  "location": { 
    "lat": 90.00,
    "lon": -71.34
  }
}
'
{
  "_index" : "test2",
  "_type" : "point2",
  "_id" : "1",
  "_version" : 3,
  "result" : "updated",
  "_shards" : {
    "total" : 2,
    "successful" : 2,
    "failed" : 0
  },
  "created" : false
}
</pre>


## Points Outside Range Rejected

<pre>
curl -XPUT -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/test2/point2/1?pretty -H 'Content-Type: application/json' -d'
{
  "text": "Geo-point as an object",
  "location": { 
    "lat": 90.01,
    "lon": -71.34
  }
}
'
{
  "error" : {
    "root_cause" : [
      {
        "type" : "mapper_parsing_exception",
        "reason" : "failed to parse"
      }
    ],
    "type" : "mapper_parsing_exception",
    "reason" : "failed to parse",
    "caused_by" : {
      "type" : "illegal_argument_exception",
      "reason" : "illegal latitude value [90.01] for location"
    }
  },
  "status" : 400
}
</pre>


## Get Mapping
<pre>
curl -XPUT -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/5092d9b1-c388-456b-b7a2-6a4c72ff2f8e_20170612/test1/1?pretty -H 'Content-Type: application/json' -d'
{
    "---geo_hash---" : "29.85753,78.87386",
    "location" : "Belgaum Airport -> Coal Harbour Seaplane Base",
    "timestamp" : 1497400186534,
    "secstodep" : -1,
    "---timestamp---" : 1497300395626,
    "objectid" : 40,
    "globalid" : "{2A8C448E-358F-4BDA-B1CD-4633F228C83E}",
    "dist" : 10697.77,
    "id" : 100000,
    "lon" : 78.87386,
    "routeid" : 6284,
    "bearing" : 14.86,
    "lat" : 29.85753,
    "speed" : 226.52,
    "geom" : "29.85753,78.87386"
}
'
</pre>

## GeoHash Fails for SRS 102100 

<pre>
curl -XPUT -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/5092d9b1-c388-456b-b7a2-6a4c72ff2f8e_20170612/test1/1?pretty -H 'Content-Type: application/json' -d'
> {
>     "---geo_hash---" : "89.99999,78.87386",
>     "location" : "Belgaum Airport -> Coal Harbour Seaplane Base",
>     "timestamp" : 1497400186534,
>     "secstodep" : -1,
>     "---timestamp---" : 1497300395626,
>     "objectid" : 40,
>     "globalid" : "{2A8C448E-358F-4BDA-B1CD-4633F228C83E}",
>     "dist" : 10697.77,
>     "id" : 100000,
>     "lon" : 78.87386,
>     "routeid" : 6284,
>     "bearing" : 14.86,
>     "lat" : 89.99999,
>     "speed" : 226.52,
>     "geom" : "89.99999,78.87386"
> }
> '
{
   "error" : {
    "root_cause" : [
      {
        "type" : "mapper_parsing_exception",
        "reason" : "failed to parse"
      }
    ],
    "type" : "mapper_parsing_exception",
    "reason" : "failed to parse",
    "caused_by" : {
      "type" : "illegal_argument_exception",
      "reason" : "illegal latitude value [89.99999] for 102100 [-89.0,89.0]"
    }
  },
  "status" : 400
}
</pre>

## BBOX Query

<pre>
curl -XGET 'localhost:9200/_search?pretty' -H 'Content-Type: application/json' -d'
{
    "query": {
        "bool" : {
            "must" : {
                "match_all" : {}
            },
            "filter" : {
                "geo_bounding_box" : {
                    "pin.location" : {
                        "top_left" : {
                            "lat" : 40.73,
                            "lon" : -74.1
                        },
                        "bottom_right" : {
                            "lat" : 40.01,
                            "lon" : -71.12
                        }
                    }
                }
            }
        }
    }
}
'

curl -XGET -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/1d1b4f2c-8024-4433-b5a3-ca2c26598580_20170612/planes2/_search -H 'Content-Type: application/json' -d'
{
    "from" : 0, 
    "size" : 10000,
    "query": {
        "bool" : {
            "must" : {
                "match_all" : {}
            },
            "filter" : {
                "geo_bounding_box" : {
                    "geom" : {
                        "top_left" : {
                            "lat" : 39,
                            "lon" : -90
                        },
                        "bottom_right" : {
                            "lat" : 38,
                            "lon" : -91
                        }
                    }
                }
            }
        }
    }
}
' > results.json




curl -XGET -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/1d1b4f2c-8024-4433-b5a3-ca2c26598580_20170612/planes2/_search?scroll=1m -H 'Content-Type: application/json' -d'
{
    "size" : 10000,
    "query": {
        "bool" : {
            "must" : {
                "match_all" : {}
            },
            "filter" : {
                "geo_bounding_box" : {
                    "geom" : {
                        "top_left" : {
                            "lat" : 39,
                            "lon" : -90
                        },
                        "bottom_right" : {
                            "lat" : 38,
                            "lon" : -91
                        }
                    }
                }
            }
        }
    }
}
'
</pre>

## Using Scroll

<pre>
curl -XGET -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/_search/scroll?scroll=1m -d 'DnF1ZXJ5VGhlbkZldGNoDwAAAAAAAtz9FlJVYUVJaVEtUjEySmdNUW9JUDg0cWcAAAAAAALc_hZSVWFFSWlRLVIxMkpnTVFvSVA4NHFnAAAAAAAC3NIWOU9samlwZ25SLTY2RzhUUWRDWVR5UQAAAAAAAwt7FnJQUENDMWJaUUdHamxpQy1sM3V5R1EAAAAAAAMBRhZyNWNyT3lydVNDeTQyR2FGeWlTSjZRAAAAAAAC3P8WUlVhRUlpUS1SMTJKZ01Rb0lQODRxZwAAAAAAAtzRFjlPbGppcGduUi02Nkc4VFFkQ1lUeVEAAAAAAALcfhZjbXBwRm5ZZVNDdV9ZWFU4bE9hcXdBAAAAAAADAUcWcjVjck95cnVTQ3k0MkdhRnlpU0o2UQAAAAAAAwt8FnJQUENDMWJaUUdHamxpQy1sM3V5R1EAAAAAAALdABZSVWFFSWlRLVIxMkpnTVFvSVA4NHFnAAAAAAAC3QEWUlVhRUlpUS1SMTJKZ01Rb0lQODRxZwAAAAAAAtzTFjlPbGppcGduUi02Nkc4VFFkQ1lUeVEAAAAAAAMBSBZyNWNyT3lydVNDeTQyR2FGeWlTSjZRAAAAAAADC30WclBQQ0MxYlpRR0dqbGlDLWwzdXlHUQ=='
 > results.json
</pre>


## Get Count

<pre>
curl -XGET -s -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/ny-data/ny-data/_search?pretty -H 'Content-Type: application/json' -d'
{
    "query": {
        "range" : {
            "utc_timestamp" : {
                "gte" : 1492315200000,
                "lte" : 1492574399000,
                "boost" : 2.0
            }
        }
    }
}
' | jq .hits.total

</pre>

## Sum of Field

<pre>
curl -XGET -s -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/ny-data-100m-2days/ny-data-100m-2days/_search?pretty -H 'Content-Type: application/json' -d'
{
	"size": 10,
    "aggs": {
        "total" : {
            "sum" : {
                "field" : "COUNT"
            }
        }
    }
}'


curl -XGET -s -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/ny-data/_settings?pretty


curl -XPOST -s -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/twitter/tweet/?pretty -H 'Content-Type: application/json' -d'
{
    "box" : "a",
    "COUNT" : 123
}
'

curl -XPOST -s -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/twitter/tweet/?pretty -H 'Content-Type: application/json' -d'
{
    "box" : "b",
    "COUNT" : 321
}
'


curl -XGET -s -u elastic:changeme data.sats-bds-datastore.l4lb.thisdcos.directory:9200/twitter/tweet/_search?pretty -H 'Content-Type: application/json' -d'
{
	"size": 10,
    "aggs": {
        "total" : {
            "sum" : {
                "field" : "COUNT"
            }
        }
    }
}'

</pre>

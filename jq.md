# jq

[jq](https://stedolan.github.io/jq/) is a very useful command line processor for json. 

## Length of an Array
If you have json file "test.json" that contains an array. The following command will output the number of items in the array.

<pre>
$ jq '. | length' test.json
</pre>

## Fields with Slashes

For Example:
<pre>
{
  "allocator/mesos/resources/cpus/total": 28,
  "master/messages_revive_offers": 13,
  "master/gpus_revocable_percent": 0,
  "master/disk_percent": 0.109690467212834,
  "master/cpus_revocable_percent": 0,
  "master/messages_status_update": 11
}
</pre>

To pull a field.
<pre>
jq '{"master/messages_status_update"}' test.json
{
  "master/messages_status_update": 11
}
</pre>

To pull just the value from a field.
<pre>
jq '.["master/messages_status_update"]' test.json
11
</pre>


## Convert JSON to compact format

`jq -c . a4iot_pretty_websats.json > a4iot_websats.json`


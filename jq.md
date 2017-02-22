#jq

[jq](https://stedolan.github.io/jq/) is a very useful command line processor for json. 

##Length of an Array
If you have json file "test.json" that contains an array. The following command will output the number of items in the array.

<pre>
$ jq '. | length' test.json
</pre>



## Testing Mat Service

The following tests show that when accessing Mat via Contour there is a limit to the number of concurrent users.  For more users you get more error message from service calls to the FeatureServer.



### Sample Calls

Using Firefox (or Chrome) collected sample calls

```
https://a4iot-services-demo.arcgis.com/maps/arcgis/rest/services/vehicle_counts_roadsensors/FeatureServer/0/query?f=json&returnGeometry=true&spatialRel=esriSpatialRelIntersects&geometry={"xmin":-8766409.89997542,"ymin":4852834.051776294,"xmax":-8609866.866047455,"ymax":5009377.08570426,"spatialReference":{"wkid":102100,"latestWkid":3857}}&geometryType=esriGeometryEnvelope&inSR=102100&outFields=*&outSR=102100
```

```
https://a4iot-services-demo.arcgis.com/maps/arcgis/rest/services/vehicle_counts_roadsensors/FeatureServer/0/query?f=json&returnGeometry=true&spatialRel=esriSpatialRelIntersects&geometry={"xmin":-8453323.832119491,"ymin":4696291.017848328,"xmax":-8296780.798191525,"ymax":4852834.051776294,"spatialReference":{"wkid":102100,"latestWkid":3857}}&geometryType=esriGeometryEnvelope&inSR=102100&outFields=*&outSR=102100
```


## Created Envelope File

Wrote a small Python script to create random geometries in the same area as the samples.

These samples will be used by JMeter to vary the requests. If you se the same geometry for all requests Elasticsearch will use cached data and responses will be faster.  In this testing; the error occured even for the same geometries.  The requests were not making it to Elasticsearch.


### Create JMeter 

For example: ``vech_count_roadsens.jmx``

#### User Defined Variables

- samples_folder: Folder containing the samples files  (e.g. /Users/davi5017/temp/MatMapService/)
- service_name: (e.g. vehicle_counts_roadsensors)
- log_folder: (e.g. ./)  The ./ will write logs to folder where you start JMeter
- server: (e.g. a4iot-services-demo.arcgis.com)
- port: (e.g. 443) https use 443

#### ThreadGroup

- Number of Threads (users): Varied from 1 to 100
- Loop Count: How many calls each user will make 

If you set 100 users and 10 calls; a total of 1000 requests will be made

#### Simple Controller

This controller contains the request definition(s) to be send by each user.  The controller allows us to load some request information from a file (e.g. geometry loads data from a file in the ``samples_folder``).

#### HTTP Request

The geometry must be URL Encoded.  

For calls directly to contour the path includes /maps (e.g. /maps/arcgis/rest/services/${service_name}/FeatureServer/0/query)

For call via the tunnel (directly to the mat pod) /maps is removed (e.g. /arcgis/rest/services/${service_name}/FeatureServer/0/query)

#### Summary Report 

Includes error percentage.

### View Results Tree

Shows each request and response.  

Requests that fail are in red.  The response headers show "503 Service Unavailable" and content "upstream connect error or disconnect/reset before headers"

### Results

#### Via External Endpoint

This includes Contour.

|Number Users|Error Percentage|
|------------|----------------|
|10          |0               |
|20          |0.3             |
|50          |11              |
|100         |62              |


#### Directly to Pod

#####  Set Hosts Entry
- Edit /etc/hosts so that server is accessed via localhost/127.0.0.1

```
127.0.0.1  localhost a4iot-services-demo.arcgis.com
```

#### Setup Port Foward

You need to run as sudo since you are using 443 (a low port).  Assumes you have kubectl installed and configured for access to the cluster you want to test.  (e.g.  pedemo)

```
sudo kubectl port-forward svc/mat-service 443:443
```

##### Results

This excludes Contour.

|Number Users|Error Percentage|
|------------|----------------|
|10          |0               |
|20          |0               |
|50          |0               |
|100         |0               |




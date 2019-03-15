# Swagger

[swagger](https://swagger.io/

## Create API

Using [Swagger Editor](https://github.com/swagger-api/swagger-editor)

You can run the Docker Image:

```
docker run -d -p 80:8080 swaggerapi/swagger-editor
```

Navigate to ```localhost```.

Used the PetStore example as strating point.

Created an API.  Found some [data type](https://swagger.io/docs/specification/data-models/data-types/) info.

## Export Configuration

You can export your configuration to yaml.

## Generate Server Stub

Many options including Play ```java-play-framework```.  Downloads as a zip ```java-play-framework-server-generated.zip```.

## Start Up

Uncompress 

```unzip java-play-framework-server-generated.zip```

Run 

```
cd java-play-framework-server
sbt run
```

Access

```
localhost:9000
```

Shows various endpoints

```
localhost:9000/api
```

Shows Petstore swagger info.  

Add ```http://localhost:9000/assets/swagger.json``` and explore then you the correct API.








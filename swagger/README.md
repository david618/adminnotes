# Swagger

[swagger](https://swagger.io/)

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

From Docker image there is no export; however, on ```https://editor.swagger.io```; there is an export option.

**Note:** I tried [Swagger CodeGen](https://swagger.io/tools/swagger-codegen/) but the exported often did not work following [wiki](https://github.com/swagger-api/swagger-codegen/wiki/server-stub-generator-howto).  I tried using swagger-codegen installed via brew. Perhaps it out of date.  

Download and compiled CodeGen on Mac.

These commands worked:

### spring

```
java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate -i /Users/davi5017/Downloads/a4iot-swagger2.yaml -l spring -o /Users/davi5017/a4iot/spring


java -jar target/swagger-spring-1.0.0.jar
```

### play

```
java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate -i /Users/davi5017/Downloads/a4iot-swagger.yaml -l java-play-framework -o /Users/davi5017/a4iot/play
/Users/davi5017/a4iot/play
sbt compile
sbt run
```

From browser: ```localhost:9000```.  This brings up a play app page.

Navigate to localhost:9000/api redirects to ```http://localhost:9000/assets/lib/swagger-ui/index.html?/url=/assets/swagger.json```



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


## Using Java Spring

Export Spring.

Unzip exported framework.

```
java -jar target/swagger-spring-1.0.0.jar
```


## Eclipse 


```
https://github.com/sbt/sbteclipse
```

Added the following to ```project\plugins.sbt```.

```
addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "5.2.4")
```

Now run ```sbt eclipse```

Then import using to Eclipse using ```Existing Project into Workspace```.

### Debugging

```
sbt run -jvm-debug 9999
Debug Configration Attach
```






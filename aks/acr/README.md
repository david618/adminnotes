## Azure Container Registry

Added Azure Container Registry (ACR) to a4iot-resources (Resource Group).  

Standard Sku: Give 100G of space; cost $0.70/day.

https://azure.microsoft.com/en-us/pricing/details/container-registry/

a4iot.azurecr.io

### Docker Login

```
docker login -u a4iot a4iot.azurecr.io
```

For password use password or password2; found under access keys in Azure Portal for this ACR.

### Pull Image from Docker Hub

```
docker pull esritrinity/realtime-mat:0.10.24.946
```

### Tag Image for ACR

```
docker tag esritrinity/realtime-mat:0.10.24.946  a4iot.azurecr.io/realtime-mat:0.10.24.946
```

### Push Image to ACR

```
docker push a4iot.azurecr.io/realtime-mat:0.10.24.946
```

### Create Kubernetes Secret 


``` 
kubectl  create secret docker-registry a4iot-docker-creds --docker-server=a4iot.azurecr.io --docker-username=a4iot --docker-password=<PASSWORD or PASSWORD2>
```

or 

Create Service Principal that can only "pull" images following https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-service-principal

You can create secret using same command as above using username SP_APP_ID and password SP_PASSWORD  
```
kubectl create secret docker-registry acr-creds \
   --docker-email=YourEmailAddress \
   --docker-server=a4iot.azurecr.io \
   --docker-username=SP_APP_ID \
   --docker-password=SP_PASSWORD 
```

Get the secret. 

```
kubectl get secret acr-creds -o yaml > somefile.yaml
```

Then edit the file as needed; removing unceessary tags. 


#### Manually Create Secret Yaml File

You could also manually create a yaml file to create secret. 

```
echo -n user-guid:password-guid | base64
dXNlci1ndWlkOnBhc3N3b3JkLWd1aWQ=
```

```
echo -n '{"auths":{"a4iot.azurecr.io":{"username":"user-guid","password":"password-guid","email":"admin@email.address","auth":"dXNlci1ndWlkOnBhc3N3b3JkLWd1aWQ"}}}' | base64
eyJhdXRocyI6eyJhNGlvdC5henVyZWNyLmlvIjp7InVzZXJuYW1lIjoidXNlci1ndWlkIiwicGFzc3dvcmQiOiJwYXNzd29yZC1ndWlkIiwiZW1haWwiOiJhZG1pbkBlbWFpbC5hZGRyZXNzIiwiYXV0aCI6ImRYTmxjaTFuZFdsa09uQmhjM04zYjNKa0xXZDFhV1EifX19
```

Create secret yaml file (e.g. a4iot.acurecr.io-secret.yaml) and put that in a4iot folder.

```
apiVersion: v1
kind: Secret
metadata:
  name: acr-creds
  namespace: REPLACE_WITH_NS
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: eyJhdXRocyI6eyJhNGlvdC5henVyZWNyLmlvIjp7InVzZXJuYW1lIjoidXNlci1ndWlkIiwicGFzc3dvcmQiOiJwYXNzd29yZC1ndWlkIiwiZW1haWwiOiJhZG1pbkBlbWFpbC5hZGRyZXNzIiwiYXV0aCI6ImRYTmxjaTFuZFdsa09uQmhjM04zYjNKa0xXZDFhV1EifX19
```



### Add to Container Spec

spec.template.spec

```
      imagePullSecrets:
      - name: a4iot-docker-creds
```

### Azure Container Instances

ACI works with Azure Container Registry; however, it doesn't work with Docker Hub at this time.



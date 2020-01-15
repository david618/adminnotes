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




### Add to Container Spec

spec.template.spec

```
      imagePullSecrets:
      - name: a4iot-docker-creds
```

### Azure Container Instances

ACI works with Azure Container Registry; however, it doesn't work with Docker Hub at this time.



#### External Load Balancer with Static Public IP


##### Create Public IP

```
az network public-ip create -g MC_dj0717a_dj0717a-cluster_eastus2 -n dj0717a-tomcat --dns-name dj0717a-tomcat --allocation-method Static
```

##### Create Deployment


Used this approach to connect to my tomcat deployment.

```
apiVersion: apps/v1beta2
kind: Deployment
metadata:
  name: tomcat-deployment
spec:
  selector:
    matchLabels:
      app: tomcat
  replicas: 1
  template:
    metadata:
      labels:
        app: tomcat
    spec:
      containers:
      - name: tomcat
        image: tomcat:9.0
        ports:
        - containerPort: 8080
```

##### Create Load Balancer

Look up the IP and use it in the service manifest.

```
apiVersion: v1
kind: Service
metadata:
  name: tomcat-deployment-external
spec:
  loadBalancerIP: 40.70.40.140
  type: LoadBalancer
  selector:
    app: tomcat
  ports:
  - protocol: TCP
    port: 8080
    targetPort: 8080
```








## Create Docker Creds Secret

username: bob
password: bobspassword

```
echo -n 'bob:bobspassword' | base64
```

```
Ym9iOmJvYnNwYXNzd29yZA==
```

```
echo -n '{"auths":{"https://index.docker.io/v1/":{"username":"bob","password":"bobspassword","email":"bob@whatever.com","auth":"Ym9iOmJvYnNwYXNzd29yZA=="}}}' | base64
```

Add ``-w 1000`` for linux.

```
eyJhdXRocyI6eyJodHRwczovL2luZGV4LmRvY2tlci5pby92MS8iOnsidXNlcm5hbWUiOiJib2IiLCJwYXNzd29yZCI6ImJvYnNwYXNzd29yZCIsImVtYWlsIjoiYm9iQHdoYXRldmVyLmNvbSIsImF1dGgiOiJZbTlpT21KdlluTndZWE56ZDI5eVpBPT0ifX19
```

Create yaml

```
apiVersion: v1
kind: Secret
metadata:
  name: docker-creds
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: eyJhdXRocyI6eyJodHRwczovL2luZGV4LmRvY2tlci5pby92MS8iOnsidXNlcm5hbWUiOiJib2IiLCJwYXNzd29yZCI6ImJvYnNwYXNzd29yZCIsImVtYWlsIjoiYm9iQHdoYXRldmVyLmNvbSIsImF1dGgiOiJZbTlpT21KdlluTndZWE56ZDI5eVpBPT0ifX19
```  


# Delete all Docker Images matching Name

For example I want to delete all images named david62243/apache-spark-testing; except the one with tage 0.1.

```
docker rmi $(docker images | grep david62243/apache-spark-testing | grep -v 0.1 | awk '{ print $3 }')
```

#!/bin/sh
set -o errexit

mvn clean install -DskipTests

docker build -t java-demo .

docker tag java-demo 127.0.0.1:5005/java-demo:latest

docker push 127.0.0.1:5005/java-demo:latest

#kubectl set image deployment/java-demo java-demo=kind-registry:5000/java-demo:latest

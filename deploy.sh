#!/bin/sh

# ./docker.sh

# Go into the noun service and deploy using Nodeshift
cd noun
npm run deploy

# Go up to the project root, not really necesarry
cd ..

kubectl create deployment adjective --image=lholmquist/insults-adjective:v0.0.1
kubectl expose deployment adjective --port=8080 --target-port=8080 --type=NodePort
oc expose service adjective

# kubectl create deployment noun --image=lholmquist/insults-noun:v0.0.1
# kubectl expose deployment noun --port=8080 --target-port=8080 --type=NodePort
# oc expose service noun

kubectl create deployment insult --image=lholmquist/insults-insult:v0.0.1
kubectl expose deployment insult --port=8080 --target-port=8080 --type=NodePort
oc expose service insult

kubectl create deployment frontend --image=lholmquist/insults-frontend:v0.0.1
kubectl expose deployment frontend --port=8080 --target-port=8080 --type=NodePort
oc expose service frontend

export FRONTEND=http://`kubectl get route frontend -o jsonpath='{.spec.host}'`

echo "Visit the front end at ${FRONTEND}"

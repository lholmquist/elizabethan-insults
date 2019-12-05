#!/bin/sh

# ./docker.sh

kubectl create deployment adjective --image=lholmquist/insults-adjective:v0.0.1
kubectl expose deployment adjective --port=8080 --target-port=8080 --type=NodePort
# oc expose service adjective

kubectl create deployment noun --image=lholmquist/insults-noun:v0.0.1
kubectl expose deployment noun --port=8080 --target-port=8080 --type=NodePort
# oc expose service noun

kubectl create deployment insult --image=lholmquist/insults-insult:v0.0.1
kubectl expose deployment insult --port=8080 --target-port=8080 --type=NodePort
# oc expose service insult

kubectl create deployment frontend --image=lholmquist/insults-frontend:v0.0.1
kubectl expose deployment frontend --port=8080 --target-port=8080 --type=NodePort
# oc expose service frontend

export HOST=http://master.montreal-091f.open.redhat.com
export PORT=`oc get svc/frontend -o jsonpath='{.spec.ports[0].nodePort}'`

echo "Visit the front end at ${HOST}:${PORT}"

#!/usr/bin/env bash

function get_host {
  kubectl config view --minify=true | grep server | awk '{ print $2 }'
}

function get_token {
  local _secret=$(kubectl get secrets | grep default | awk '{ print $1 }')
  kubectl describe secret ${_secret} | grep -E "^token" | awk '{ print $2 }'
}

APP=kuberlex
IMAGE=vitorenesduarte/kuberlex
HOST=$(get_host)
TOKEN=$(get_token)
FILE=${APP}.yaml

cat <<EOF > ${FILE}
apiVersion: v1
kind: Pod
metadata:
  name: ${APP}
spec:
  restartPolicy: Never
  containers:
  - name: ${APP}
    image: ${IMAGE}
    imagePullPolicy: Always
    env:
    - name: HOST 
      value: "${HOST}"
    - name: TOKEN
      value: "${TOKEN}"
EOF

kubectl create -f ${FILE}

while [ $(kubectl get pod ${APP} | grep Running 2> /dev/null | wc -l) -ne 1 ]; do
  sleep 1
done

kubectl logs -f ${APP}

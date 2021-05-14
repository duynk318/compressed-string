#!/bin/sh

IMAGE=$1
KUBECONFIG=$2

cat <<EOF | ${KUBECONFIG} kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: compressed-string
  labels:
    app: compressed-string
spec:
  replicas: 1
  selector:
    matchLabels:
      app: compressed-string
  template:
    metadata:
      labels:
        app: compressed-string
    spec:
      containers:
      - name: compressed-string
        image: ${IMAGE} 
        ports:
        - containerPort: 8080
          name: http
          protocol: TCP
EOF


#!/usr/bin/env bash
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm search repo nginx-stable

helm -n nginx delete nginx || echo "No existing release found"
kubectl delete ns nginx || echo "No existing namespace found"

echo "Creating nginx namespace"
kubectl create ns nginx
kubectl label ns nginx helmDelete=true

echo "Deploying chart nginx/nginx"
helm install nginx nginx-stable/nginx-ingress \
    --namespace nginx
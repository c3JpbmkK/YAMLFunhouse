#!/usr/bin/env bash
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm search repo jetstack

helm -n cert-manager delete cert-manager || echo "No existing release found"
kubectl delete ns cert-manager || echo "No existing namespace found"

echo "Creating cert-manager namespace"
kubectl create ns cert-manager
helm install cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --version v1.7.1 \
    --set prometheus.enabled=false \
    --set installCRDs=true
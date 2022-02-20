#!/usr/bin/env bash
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
helm search repo falcosecurity

helm -n falco delete falco || echo "No existing release found"
kubectl delete ns falco || echo "No existing namespace found"

echo "Creating falco namespace"
kubectl create ns falco
kubectl label ns falco helmDelete=true

echo "Deploying chart falcosecurity/falco"
helm install falco falcosecurity/falco \
    --namespace falco

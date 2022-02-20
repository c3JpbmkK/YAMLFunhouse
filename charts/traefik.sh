#!/usr/bin/env bash
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
helm search repo traefik

helm -n traefik delete traefik || echo "No existing release found"
kubectl delete ns traefik || echo "No existing namespace found"

echo "Creating traefik namespace"
kubectl create ns traefik
kubectl label ns traefik helmDelete=true

echo "Deploying chart traefik/traefik"
helm install traefik traefik/traefik \
    --namespace traefik \
    --set ingressClass.enabled=true \
    --set pilot.enabled=true \
    --set ingressRoute.dashboard.enabled=true \
    --set logs.general.format=json \
    --set logs.general.level=INFO \
    --set tracing.instana.enabled=true




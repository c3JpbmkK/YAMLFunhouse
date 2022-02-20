#!/usr/bin/env bash
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
helm search repo traefik

helm -n traefik delete traefik || echo "No existing release found"
kubectl delete ns traefik || echo "No existing namespace found"

echo "Creating traefik namespace"
kubectl create ns traefik
helm install --namespace traefik traefik traefik/traefik


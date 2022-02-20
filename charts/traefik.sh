#!/usr/bin/env bash
helm repo add traefik https://helm.traefik.io/traefik
helm repo update

helm delete --namespace traefik traefik || echo "Error deleting non-existent release"
kubectl delete ns traefik || echo "Error deleting non-existent namespace"
kubectl create ns traefik

helm install --namespace traefik traefik traefik/traefik


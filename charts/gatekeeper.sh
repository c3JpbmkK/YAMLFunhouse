#!/usr/bin/env bash
helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
helm repo update
helm search repo gatekeeper

helm -n gatekeeper-system delete gatekeeper || echo "No existing release found"
kubectl delete ns gatekeeper-system || echo "No existing namespace found"

echo "Creating gatekeeper-system namespace"
kubectl create ns gatekeeper-system
helm install gatekeeper gatekeeper/gatekeeper \
    --namespace gatekeeper-system
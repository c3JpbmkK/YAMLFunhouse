#!/usr/bin/env bash
helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
helm repo update
helm search repo gatekeeper

helm install gatekeeper gatekeeper/gatekeeper --namespace gatekeeper-system --create-namespace

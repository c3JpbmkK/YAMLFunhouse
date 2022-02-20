#!/usr/bin/env bash
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
helm search repo falcosecurity

helm install falco falcosecurity/falco

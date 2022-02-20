#!/usr/bin/env bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm search repo prometheus-community

helm -n monitoring delete kube-prometheus || echo "No existing release found"
kubectl delete ns monitoring || echo "No existing monitoring namespace found"

echo "Creating monitoring namespace"
kubectl create ns monitoring
kubectl label ns monitoring istio-injection=enabled
helm install kube-prometheus prometheus-community/kube-prometheus-stack \
	--namespace monitoring \
	--set grafana.ingress.enabled=true \
	--set grafana.ingress.hosts={"grafana.sysctls.com"}

#!/usr/bin/env bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm search repo prometheus-community

helm -n kube-prometheus delete kube-prometheus || echo "No existing release found"
kubectl delete ns kube-prometheus || echo "No existing namespace found"

echo "Creating kube-prometheus namespace"
kubectl create ns kube-prometheus
helm install kube-prometheus prometheus-community/kube-prometheus-stack \
	--namespace kube-prometheus \
	--set grafana.ingress.enabled=true \
	--set grafana.ingress.hosts={"grafana.sysctls.com"}

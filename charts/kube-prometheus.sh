#!/usr/bin/env bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm search repo prometheus-community

helm -n kube-prometheus delete kube-prometheus || echo "No existing release found"
kubectl delete ns kube-prometheus || echo "No existing namespace found"

echo "Creating kube-prometheus namespace"
kubectl create ns kube-prometheus
kubectl label ns kube-prometheus helmDelete=true

echo "Deploying chart prometheus-community/kube-prometheus-stack"
helm install kube-prometheus prometheus-community/kube-prometheus-stack \
	--namespace kube-prometheus \
	--set grafana.ingress.enabled=true \
	--set grafana.ingress.hosts={"grafana.sysctls.com"} \
	--set grafana.ingress.tls[0].hosts={"grafana.sysctls.com"} \
	--set grafana.ingress.tls[0].secretName=grafana-sysctls-com-tls-secret \
	--set grafana.ingress.annotations."cert-manager\.io/cluster-issuer"=letsencrypt-staging \
	--set grafana.ingress.annotations."kubernetes\.io/ingress\.class"=nginx
#!/usr/bin/env bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm search repo prometheus-community

echo "Creating monitoring namespace"
kubectl create ns monitoring || echo "Namespace already exists"
kubectl label ns/monitoring istio-injection=enabled || echo "Namespace already labelled istio-injection"
helm install --namespace monitoring kube-prometheus prometheus-community/kube-prometheus-stack 

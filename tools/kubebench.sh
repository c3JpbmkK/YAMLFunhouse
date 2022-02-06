#!/usr/bin/env bash

echo "Deleting any existing kubebench job"
kubectl delete jobs kube-bench || echo "No kube-bench job found"

echo "Creating new kube-bench job"
kubectl apply -f https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml

PodName=$(kubectl get pods -o name -l app=kube-bench)
Status=$(kubectl get ${PodName} -o json | jq -r ".status.phase")
while [ "${Status}" != "Succeeded" ]
do
echo "Waiting for ${PodName} to complete"
sleep 1
Status=$(kubectl get ${PodName} -o json | jq -r ".status.phase")
done

echo "Trailing logs from ${PodName}"
kubectl logs ${PodName}

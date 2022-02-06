#!/usr/bin/env bash

kubectl delete jobs kube-bench
kubectl apply -f https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml

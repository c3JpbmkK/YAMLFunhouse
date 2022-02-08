#!/usr/bin/env bash

watch 'kubectl get ns --show-labels;echo;kubectl get pods -A --show-labels | grep -v kube-system ; echo ; kubectl get svc -A --show-labels | grep -v kube-system'

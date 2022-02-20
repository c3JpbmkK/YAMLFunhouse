#!/usr/bin/env bash

echo "Deploying ClusterIssuer letsencrypt-staging"
read -p "Enter ingressClassName: " -a IngressClass
kubectl create -f -<<EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    email: postmaster@sysctls.com
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: sysctls-com-staging-private-key
    solvers:
    - http01:
        ingress:
          class: $IngressClass
EOF

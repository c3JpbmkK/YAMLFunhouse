#!/usr/bin/env bash

Releases=$(helm list --all-namespaces --deployed --output json)
ReleasesCount=$(echo "$Releases" | jq "length")

while [ $ReleasesCount -gt 0 ]
do
    CurrentIndex=$(( $ReleasesCount - 1 ))
    ReleaseName=$(echo "$Releases" | jq -r ".[$CurrentIndex].name")
    ReleaseNamespace=$(echo "$Releases" | jq -r ".[$CurrentIndex].namespace")
    echo "Deleting release $ReleaseName in namespace $ReleaseNamespace"
    helm delete --namespace "$ReleaseNamespace" "$ReleaseName"
    ReleasesCount=$(( $ReleasesCount - 1 ))
done

echo "Deleting all namespaces with selector helmDelete=true"
kubectl delete ns -l helmDelete=true
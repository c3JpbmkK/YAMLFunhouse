#!/usr/bin/env bash

set -eo pipefail

read -p "Enter a name of the resource group(to delete): " resourceGroup

echo "Deleting resource group ${resourceGroup}(location=westeurope)"
az group delete --name $resourceGroup --yes --no-wait

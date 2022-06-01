#!/usr/bin/env bash

set -eo pipefail

read -p "Enter a name for the resource group: " resourceGroup

echo "Creating resource group (location=westeurope)"
az group create --name $resourceGroup --location "westeurope"

echo "Creating resources"
az deployment group create --resource-group $resourceGroup \
    --template-file bicep/main.bicep \
    --parameters sshPublicKey="$(cat ~/.ssh/id_rsa.pub)"

echo "Getting Public IPs"
az vm list-ip-addresses --query [].[virtualMachine.name,virtualMachine.network.publicIpAddresses[0].ipAddress] -o tsv \
    | tr '\t' ' ' \
    | awk -F " " '{print $1" ansible_host="$2}'
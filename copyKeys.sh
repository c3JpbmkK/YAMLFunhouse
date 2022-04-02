#!/usr/bin/env bash

# Requirements
# 1. Ansible Vault 
# 2. Sshpass

# Create SSH key if it doesnt exist
if [ ! -f ~/.ssh/id_rsa.pub ]
then
	ssh-keygen -t rsa -b 4096 -C "ansible@control.sysctls.com" -P "" -f ~/.ssh/id_rsa
fi

# Kill previous ssh-agent processes
pkill ssh-agent

# Start a new ssh-agent process and add default identity
eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa

# This step requires a text file ".vault" containig the vault password
# and a Ansible Vault encrypted ".password" file containing the SSH password
export SSHPASS=$(ansible-vault view .password --vault-password-file .vault)

for server_number in $(seq 1 4)
do 
	# sshpass -e retrieves the SSH password from the SSHPASS environment variable
	sshpass -e ssh-copy-id -o StrictHostKeyChecking=no root@server${server_number}
done

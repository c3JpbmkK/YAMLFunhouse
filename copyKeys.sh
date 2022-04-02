#!/usr/bin/env bash

if [ ! -f ~/.ssh/id_rsa.pub ]
then
	ssh-keygen -t rsa -b 4096 -C "ansible@control.sysctls.com" -P "" -f ~/.ssh/id_rsa
fi

# Kill previous ssh-agent processes
pkill ssh-agent

# Start a new ssh-agent process and add identities
eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa

export SSHPASS=$(ansible-vault view .password --vault-password-file .vault)

for address in $(seq 2 5)
do 
	sshpass -e ssh-copy-id -o StrictHostKeyChecking=no root@10.20.30.$address
done

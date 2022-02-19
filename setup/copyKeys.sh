#!/usr/bin/env bash

if [ ! -f ~/.ssh/id_rsa ]
then
	ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -C "ansible@control.sysctls.com" -P ""
fi

pkill ssh-agent || echo "No ssh-agent processes running"
echo "Starting new ssh-agent"
eval $(ssh-agent)
ssh-add

export SSHPASS=$(ansible-vault view password.yml --vault-password-file vault.txt)

# Control plane nodes
for i in $(seq 1 3)
do
	sshpass -e ssh-copy-id -o StrictHostKeyChecking=No -o ConnectTimeout=1 root@master$i
done

# Worker plane nodes
for i in $(seq 1 3)
do
	sshpass -e ssh-copy-id -o StrictHostKeyChecking=No -o ConnectTimeout=1 root@worker$i
done

# API server load balancer node
sshpass -e ssh-copy-id -o StrictHostKeyChecking=No root@lb

ansible -m copy -a "src=/etc/hosts dest=/etc/hosts" all

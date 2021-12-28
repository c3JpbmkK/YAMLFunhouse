# Bring up a cluster using Ansible
# Why ? Why not :) 

When VMs are preconfigured (network and SSH) 

* To bring up a cluster: ansible-playbook site.yml
  * To use a different cni plugin (default is Weave): ansible-playbook site.yml -e cni_plugin=cilium
* To destroy a cluster: ansible-playbook teardown.yml  

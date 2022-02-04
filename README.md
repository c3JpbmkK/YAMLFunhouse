# Bring up a cluster using Ansible  

Why ? Why not  
Plus I'm learning to use Ansible :grinning:  

## Setup  

* host:  
  * os: Windows
  * cpu: 4 (8 logical)  
  * memory: 16GB  
* vm_provisioner: vmware
* vms:
  * control_plane_nodes: 3
  * worker_nodes: 3
  * loadbalancer_node: 1
  * ansible_control_node: 1 (optional, you can use Ansible directly from host, but I have a Windows host :confused:)
* guest:
  * os: linux(Linux 4.18.0-348.7.1.el8_5.x86_64)
  * cpu:
    * control_plane_nodes: 2
    * worker_nodes: 2
  * memory:
    * control_plane_nodes: 2GB
    * worker_nodes: 4GB
* network:
  * host only private network for vms (+NAT for ansible control node)
  * (vmware) LAN segment for control plane nodes
  * (vmware) LAN segment for worker nodes

## Steps  

When VMs are preconfigured (network and SSH) 

* To bring up a cluster: ansible-playbook site.yml
  * To add multiple nodes to the control plane: ansible-playbook site.yml -e high_availability=true
  * To use a different cni plugin (default is Weave): ansible-playbook site.yml -e cni_plugin=cilium
* To destroy a cluster: ansible-playbook teardown.yml  

## Options  
  
| EXTRA_VARS  | TYPE  | DEFAULT | DESCRIPTION |
|-------------------  |:------: |:-------:  |-----------------------------------------------  |
| cni_plugin  | string 	| | Use a different CNI plugin (default is Weave)  |
| high_availability | bool  | false | Join additional nodes to the control plane  |
| install_falco | bool  |  false | Install necessary packages and modules for running Falco daemonsets  |


## Upcoming (maybe)  

* Break roles/kubernetes into playbooks. Why? Its not really a role, its just playbooks put together into the tasks folder  
* Automated loadbalancer node configuration  
* Automated VM provisioning  

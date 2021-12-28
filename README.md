# Bring up a cluster using Ansible  

Why ? Why not :grinning:  
Plus I'm learning to use Ansible  

## Setup  

* host: Windows  
  * cpu: 4 (8 logical)  
  * memory: 16GB  
* vm_provisioner: vmware
* vms:
  * control_plane_nodes: 3
  * worker_nodes: 3
  * loadbalancer_node: 1
  * ansible_control_node: 1 (optional, you can use Ansible directly from host, but I have a Windows host :confused:)
* guest:
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
  
| EXTRA_VARS        	|  TYPE  	| DEFAULT 	| DESCRIPTION                                   	|
|-------------------	|:------:	|:-------:	|-----------------------------------------------	|
| high_availability 	|  bool  	|  false  	| Join additional nodes to the control plane    	|
| cni_plugin        	| string 	|         	| Use a different CNI plugin (default is Weave) 	|

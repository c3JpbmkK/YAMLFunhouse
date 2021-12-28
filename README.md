# Bring up a cluster using Ansible  

Why ? Why not :)  
Plus I'm learning to use Ansible  

## Environment  

* host: Windows  
  * cpu: 4 (8 logical)  
  * memory: 16GB  
* vm_provisioner: vmware
* guest:
  * cpus:
    * control_plane_nodes: 2
    * worker_nodes: 2
  * memory:
    * control_plane_nodes: 2GB
    * worker_nodes: 4GB

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

<i>My playbook to install kubernetes in configuration: k8s master + 1 or more worker</i>
## Prerequisites
1. At least 2 VM or physical server
1. Server with installed ansible (playbook tested with ansible ansible 2.4.2.0,2.8.5) Server must have connectivity with all servers for installing (ssh key or root password or other way)
1. Installed git client on server with ansible

## Preparing virtual environment on Windows (tested on Windows 10)
### Step-by-step instruction
<i>Note</i>. Some commands can looks and use different and depending on the version of software used<br>
<i>Note</i>. You can change file [provision.sh](https://github.com/Uglykoyote/myk8s/blob/master/localenv/provision.sh) 
<i>Note</i>. You can change file [Vagrantfile](https://github.com/Uglykoyote/myk8s/blob/master/localenv/Vagrantfile) 

1. Make local directory on Windows disk
1. Download [Vagrantfile](https://github.com/Uglykoyote/myk8s/blob/master/localenv/Vagrantfile) and put into dir
1. Download [provision.sh](https://github.com/Uglykoyote/myk8s/blob/master/localenv/provision.sh) and put into dir
1. Open cmd
1. Switch into directory with Vagrantfile and provision.sh files
1. Run command for create virtual servers
```bash
vagrant up
```

#### provision.sh 
*(if you want add your pub key during process for creating VM, you must remove # and replace text "put_here_content_your_id_rsa_pub_key" with your pub key from ansible server before running proccess)*

| Before | After |
|---|---|
|#mykey="put_here_content_your_id_rsa_pub_key" | mykey="ssh-rsa AAAAB3NzaC1yc2..."|

#### Vagrantfile
| Before | After | Descriptions |
|---|---|---|
|$private_net = "172.0.1."| $private_net = "172.0.200."|Change network if default value <br>have any conflict with current networks|
|$count_of_worker_nodes = 1| $count_of_worker_nodes = n|Change n for replace with the required <br>number of virtual servers, but not less 1|

## Usable variables
*Note. You can redeifne variables by extravars, for example add -e 'podnetworkcidr=10.243.0.0' for ansible command*

Name | Default value | Description
---| :---: | ---
podnetworkcidr | 10.244.0.0 | Pod network on the cluster so that your Pods can talk to each other
manageuser | k8smanager | User for managing of kubernetes cluser
managegroup | k8smanagers | A dedicated group for user for managing of kubernetes cluser

## Installation Kubernetes
1. Get connect into Ansible-server
2. Clone [project](https://github.com/Uglykoyote/myk8s)
```bash
git clone git@github.com:Uglykoyote/myk8s.git
```
3. Change directory to kubernetes
```bash
cd kubernetes
```
4. Make all needed change in file group_vars/all and k8s.inventory
5. Run pre-install check with ansible ad-hoc command:
```bash
ansible -i k8s.inventory all -m ping

$ ansible -i k8s.inventory all -m ping
k8sworker1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
k8smaster | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}

```
<i>Note</i>. Allowed only SUCCESS answer in output

6. Run installation process with ansible command (after making change in k8s.inventory, you can find example below):
```bash
ansible-playbook -i k8s.inventory k8s_install.yml
```
<i>or (If you need redefine username for managing k8s cluster)</i>
```bash
ansible-playbook k8s_install.yml -i k8s.inventory -e 'manageuser=mysuperuser'
```

#### Example of k8s.inventory
*Note. We use 172.0.200.0/24 network, 1 master and 2 worker nodes*
```bash
cat k8s.inventory
[master]
k8smaster  ansible_host=172.0.200.10

[nodes]
k8sworker1 ansible_host=172.0.200.15

[cluster:children]
master
nodes
```

## Helpful information
You can read info about project with k8s full-test [sonobuoy](https://github.com/vmware-tanzu/sonobuoy)

## Source code
The source code is currently available on Github: https://github.com/Uglykoyote/myk8s

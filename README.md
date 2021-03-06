vagrant-hadoop-spark-cluster
============================

# 1. Introduction
### Vagrant project to spin up a cluster of 4, 32-bit CentOS6.5 Linux virtual machines with Hadoop v2.7.3.
Ideal for development cluster on a laptop with at least 4.5 GB of memory.

1. node1 : HDFS NameNode + DataNode + YARN NodeManager
2. node2 : YARN ResourceManager + JobHistoryServer + ProxyServer + DataNode + YARN NodeManager
3. node3 : HDFS DataNode + YARN NodeManager

# 2. Prerequisites and Gotchas to be aware of
1. At least 1.5GB memory for each VM node. Default script is for 3 nodes, so you need 3GB for the nodes, in addition to the memory for your host machine.
2. Vagrant 1.7 or higher, Virtualbox 4.3.2 or higher
3. Preserve the Unix/OSX end-of-line (EOL) characters while cloning this project; scripts will fail with Windows EOL characters.
4. Project is tested on Ubuntu 32-bit 14.04 LTS host OS; not tested with VMware provider for Vagrant.
5. The Vagrant box is downloaded to the ~/.vagrant.d/boxes directory. On Windows, this is C:/Users/{your-username}/.vagrant.d/boxes.

# 3. Getting Started
1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/downloads.html).
3. `vagrant plugin install vagrant-hostmanager`
4. Run ```vagrant box add centos65 http://files.brianbirkinbine.com/vagrant-centos-65-i386-minimal.box```
5. Git clone this project, and change directory (cd) into this project (directory).
6. [Download Hadoop 2.7.3 (hadoop-2.7.3.tar.gz) into the /resources directory](http://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz)
7. [Download Java JDK 8u121 (jdk-8u121-linux-i586.tar.gz) into the /resources directory](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
8. Run ```vagrant up``` to create the VM.
9. Run ```vagrant ssh``` to get into your VM.
10. Run ```vagrant destroy``` when you want to destroy and get rid of the VM.


# 4. Modifying scripts for adapting to your environment
You need to modify the scripts to adapt the VM setup to your environment.  

1. [List of available Vagrant boxes](http://www.vagrantbox.es)

2. ./Vagrantfile  
To add/remove slaves, change the number of nodes:  
line 5: ```numNodes = 3```  
To modify VM memory change the following line:  
line 13: ```v.customize ["modifyvm", :id, "--memory", "1500"]```  
3. /scripts/common.sh  
To use a different version of Java, change the following line depending on the version you downloaded to /resources directory.  
line 4: JAVA_ARCHIVE=jdk-8u121-linux-i586.tar.gz  
To use a different version of Hadoop you've already downloaded to /resources directory, change the following line:  
line 8: ```HADOOP_VERSION=hadoop-2.7.3```  
To use a different version of Hadoop to be downloaded, change the remote URL in the following line:  
line 10: ```HADOOP_MIRROR_DOWNLOAD=http://apache.crihan.fr/dist/hadoop/common/stable/hadoop-2.6.0.tar.gz```  

3. /scripts/setup-java.sh  
To install from Java downloaded locally in /resources directory, if different from default version (8u121), change the version in the following line:  
line 18: ```ln -s /usr/local/jdk1.8.0_121 /usr/local/java```  
To modify version of Java to be installed from remote location on the web, change the version in the following line:  
line 12: ```yum install -y jdk-8u121-linux-i586```


# 5. Post Provisioning
After you have provisioned the cluster, you need to run some commands to initialize your Hadoop cluster. SSH into node1 using  
```vagrant ssh node-1```
Commands below require root permissions. Change to root access using ```sudo su``` or create a new user and grant permissions if you want to use a non-root access. In such a case, you'll need to do this on VMs.

Issue the following command.

1. $HADOOP_PREFIX/bin/hdfs namenode -format myhadoop

## Start Hadoop Daemons (HDFS + YARN)
From the host machine:

    ./startup.sh

### Test YARN
Run the following command to make sure you can run a MapReduce job.

```
yarn jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar pi 2 100
```

# 6. Web UI
You can check the following URLs to monitor the Hadoop daemons.

1. [NameNode] (http://10.211.55.101:50070/dfshealth.html)
2. [ResourceManager] (http://10.211.55.102:8088/cluster)
3. [JobHistory] (http://10.211.55.102:19888/jobhistory)

# 7. References
This project was put together with great pointers from all around the internet. All references made inside the files themselves.
Primarily this project is forked from [Jee Vang's vagrant project](https://github.com/vangj/vagrant-hadoop-2.4.1-spark-1.0.1)

# 8. Copyright Stuff
Copyright 2014 Maloy Manna

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

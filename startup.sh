#!/bin/bash

# Script to startup HDFS on node-1 and ResourceManager on node-2

vagrant ssh node-1 -c 'sudo $HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode'
vagrant ssh node-1 -c 'sudo $HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs start datanode'

vagrant ssh node-2 -c 'sudo $HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager'
vagrant ssh node-2 -c 'sudo $HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR start nodemanager'
vagrant ssh node-2 -c 'sudo $HADOOP_YARN_HOME/sbin/yarn-daemon.sh start proxyserver --config $HADOOP_CONF_DIR'
vagrant ssh node-2 -c 'sudo $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR'

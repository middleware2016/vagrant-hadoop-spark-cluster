#!/bin/bash

# Script to startup HDFS + Yarn

vagrant ssh node-1 -c 'sudo $HADOOP_PREFIX/sbin/start-dfs.sh'

vagrant ssh node-2 -c 'sudo $HADOOP_PREFIX/sbin/start-yarn.sh'
vagrant ssh node-2 -c 'sudo $HADOOP_PREFIX/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start proxyserver'
vagrant ssh node-2 -c 'sudo $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR start historyserver'

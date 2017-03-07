#!/bin/bash

# Script to shutdown HDFS + Yarn

vagrant ssh node-1 -c 'sudo $HADOOP_PREFIX/sbin/stop-dfs.sh'

vagrant ssh node-2 -c 'sudo $HADOOP_PREFIX/sbin/stop-yarn.sh'
vagrant ssh node-2 -c 'sudo $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR stop historyserver'

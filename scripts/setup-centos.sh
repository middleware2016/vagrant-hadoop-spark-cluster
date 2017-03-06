#!/bin/bash
source "/vagrant/scripts/common.sh"

function disableFirewall {
	echo "disabling firewall"
	service iptables save
	service iptables stop
	chkconfig iptables off
}

function installTools {
    yum -y install vim zip unzip htop tmux
}

echo "setup centos"

disableFirewall
installTools

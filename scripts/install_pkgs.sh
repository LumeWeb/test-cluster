#!/bin/bash

apt-get update
apt-get -y install software-properties-common
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64
add-apt-repository ppa:rmescandon/yq -y
apt-get update
apt-get install -y yq jq pass
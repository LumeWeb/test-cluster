#!/bin/bash

YQ_VERSION="v4.44.5"

curl -L -o /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 \
 && chmod +x /usr/local/bin/yq
apt-get update
apt-get install -y jq pass
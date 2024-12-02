#!/bin/bash

echo $(yq eval '.providers[].address' $TERRATEAM_ROOT/config/akash-providers.yaml | jq -R -s -c 'split("\n")[:-1]')
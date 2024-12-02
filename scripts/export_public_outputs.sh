#!/bin/bash

cd "$TERRATEAM_ROOT"/"$TERRATEAM_DIR" && \
terraform output -json | \
jq -r 'to_entries |
  map(select(.value.sensitive == false)) |
  .[] |
  if (.key | startswith("TF_VAR_")) then
    "export \(.key)=\(.value.value)"
  else
    "export TF_VAR_\(.key)=\(.value.value)"
  end'
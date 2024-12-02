#!/bin/bash
# Only export non-sensitive outputs
cd "$TERRATEAM_ROOT"/"$TERRATEAM_DIR" && terraform output -json | \
  jq -r 'to_entries |
    map(select(.value.sensitive == false)) |
    .[] |
    "export \(.key)=\(.value.value)"'
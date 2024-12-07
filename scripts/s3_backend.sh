#!/bin/bash

# Get current directory name
DIR_NAME=$(basename "$PWD")

# Access environment variables/secrets
BUCKET="${AWS_BUCKET}"
REGION="us-east-1"
KEY="${DIR_NAME}/terraform.tfstate"

export TF_VAR_aws_bucket="${BUCKET}"

# Generate backend config file
cat > backend.hcl << EOF
bucket                      = "${BUCKET}"
region                      = "${REGION}"
key                         = "${KEY}"
EOF
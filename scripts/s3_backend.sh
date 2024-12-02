#!/bin/bash

# Access environment variables/secrets
BUCKET="${AWS_BUCKET}"
REGION="us-east-1"
KEY="test/terraform.tfstate"

# Generate backend config file
cat > backend.hcl << EOF
bucket                      = "${BUCKET}"
region                      = "${REGION}"
key                         = "${KEY}"
access_key                  = "${AWS_ACCESS_KEY_ID}"
secret_key                  = "${AWS_SECRET_ACCESS_KEY}"
EOF

env | grep AWS


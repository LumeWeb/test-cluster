#!/bin/bash

# Access environment variables/secrets
BUCKET="${AWS_BUCKET}"
REGION="${AWS_REGION}"
KEY="test/terraform.tfstate"

# Generate backend config file
cat > backend.hcl << EOF
bucket                      = "${BUCKET}"
region                      = "${REGION}"
key                         = "${KEY}"
skip_credentials_validation = true
skip_requesting_account_id  = true
skip_metadata_api_check     = true
skip_region_validation      = true
skip_s3_checksum            = true
EOF


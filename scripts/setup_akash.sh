#!/bin/bash
set -e

# Move provider-services binary
if [ -f "${GITHUB_WORKSPACE}/bin/provider-services" ]; then
    mv "${GITHUB_WORKSPACE}/bin/provider-services" /usr/local/bin/
    chmod +x /usr/local/bin/provider-services
    echo "✓ Moved provider-services binary to /usr/local/bin/"
else
    echo "! provider-services binary not found in ${GITHUB_WORKSPACE}/bin/"
    exit 1
fi

# Create Akash directory
mkdir -p ~/.config/akash
chmod 700 ~/.config/akash

# Copy files from workspace if they exist
if [ -d "/github/workspace/.akash-config" ]; then
    cp -r /github/workspace/.akash-config/* ~/.config/akash/ 2>/dev/null || true
fi

# Set correct permissions
find ~/.config/akash -type f -exec chmod 600 {} \; 2>/dev/null || true

# Verify setup
echo "Akash directory contents:"
ls -la ~/.config/akash || echo "No files in ~/.config/akash"

# Verify Akash CLI is available
if command -v provider-services &> /dev/null; then
    echo "✓ Akash CLI is available"
    provider-services version
else
    echo "! Akash CLI not found"
    exit 1
fi

exit 0
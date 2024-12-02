#!/bin/bash
set -e

# Create GPG directory
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg

# Copy files from workspace if they exist
if [ -d "/github/workspace/.gnupg" ]; then
    cp -r /github/workspace/.gnupg/* ~/.gnupg/ 2>/dev/null || true
fi

# Ensure GPG configs exist
if [ ! -f ~/.gnupg/gpg.conf ]; then
    echo "pinentry-mode loopback" > ~/.gnupg/gpg.conf
fi

if [ ! -f ~/.gnupg/gpg-agent.conf ]; then
    echo "allow-loopback-pinentry" > ~/.gnupg/gpg-agent.conf
fi

# Set correct permissions
chmod 600 ~/.gnupg/*

# Kill any existing gpg-agent processes
killall -9 gpg-agent 2>/dev/null || true

# Verify setup
echo "GPG directory contents:"
ls -la ~/.gnupg || echo "No files in ~/.gnupg"

echo -e "\nGPG config contents:"
cat ~/.gnupg/gpg.conf || echo "No gpg.conf found"

echo -e "\nGPG agent config contents:"
cat ~/.gnupg/gpg-agent.conf || echo "No gpg-agent.conf found"

# Restart GPG agent
gpg-connect-agent reloadagent /bye

exit 0
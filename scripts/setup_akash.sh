#!/bin/bash
set -e

# Environment variables required:
# WALLET_NAME - Name of the Akash wallet
# MNEMONIC - Mnemonic for wallet recovery
# CERT_ID - Certificate ID
# CERT_CONTENT - Certificate content

# Initialize GPG
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
echo "pinentry-mode loopback" > ~/.gnupg/gpg.conf
echo "allow-loopback-pinentry" > ~/.gnupg/gpg-agent.conf
gpg-connect-agent reloadagent /bye

# Create and setup GPG key
cat >key-config <<EOF
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: Akash Deploy Key
Name-Email: akash@localhost
Expire-Date: 0
%no-protection
%commit
EOF

# Generate key
gpg --batch --quiet --generate-key key-config

# Get fingerprint and set ultimate trust
GPG_FINGERPRINT=$(gpg --list-secret-keys --with-colons | grep ^fpr | tail -n1 | cut -d: -f10)
echo "$GPG_FINGERPRINT:6:" | gpg --import-ownertrust

# Get key ID and initialize pass
apt-get update && apt-get install -y pass
GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG 2>/dev/null | grep sec | tail -n1 | awk '{print $2}' | cut -d'/' -f2)
pass init "$GPG_KEY_ID"

# Clean up GPG config
rm key-config

# Setup Akash
mkdir -p ~/.akash
chmod 700 ~/.akash

# Setup Certificate
echo "$CERT_CONTENT" > "$HOME/.akash/$CERT_ID.pem"
chmod 600 "$HOME/.akash/$CERT_ID.pem"

# Recover Akash wallet
WALLET_OUTPUT=$(echo "$MNEMONIC" | provider-services keys add "$WALLET_NAME" --recover --output json)
AKASH_ADDRESS=$(echo "$WALLET_OUTPUT" | jq -r '.address')

# Export variables for subsequent steps
{
  echo "AKASH_GPG_FINGERPRINT=$GPG_FINGERPRINT"
  echo "AKASH_GPG_KEY_ID=$GPG_KEY_ID"
  echo "AKASH_ADDRESS=$AKASH_ADDRESS"
} >> /container.env

echo "✓ Container environment setup complete"
echo "✓ GPG Fingerprint: $GPG_FINGERPRINT"
echo "✓ GPG Key ID: $GPG_KEY_ID"
echo "✓ Akash Address: $AKASH_ADDRESS"
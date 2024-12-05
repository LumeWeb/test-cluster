#!/bin/bash
set -e

# Environment variables required:
# AKASH_WALLET_SEED - Mnemonic for wallet recovery
# AKASH_CERT_ID - Certificate ID
# AKASH_CERT_CONTENT - Certificate content

WALLET_NAME="akash_deploy"

# Install Akash provider services
curl -sfL https://raw.githubusercontent.com/akash-network/provider/main/install.sh | bash
cp ./bin/provider-services /usr/local/bin

if ! command -v python3 &> /dev/null; then
    echo "python3 is required but not installed" >&2
    exit 1
fi

if ! command -v pip3 &> /dev/null; then
    echo "pip3 is required but not installed" >&2
    exit 1
fi

# Install required packages if not present
pip3 install aiohttp --quiet

# Run the RPC tester
python3 bash_rpc_tester.py "https://raw.githubusercontent.com/akash-network/net/main/mainnet/rpc-nodes.txt"

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
GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG 2>/dev/null | grep sec | tail -n1 | awk '{print $2}' | cut -d'/' -f2)
pass init "$GPG_KEY_ID"

# Clean up GPG config
rm key-config

# Setup Akash
mkdir -p ~/.akash
chmod 700 ~/.akash

# Setup Certificate
echo "$AKASH_CERT_CONTENT" > "$HOME/.akash/$AKASH_CERT_ID.pem"
chmod 600 "$HOME/.akash/$AKASH_CERT_ID.pem"

# Recover Akash wallet
WALLET_OUTPUT=$(echo "$AKASH_WALLET_SEED" | provider-services keys add "$WALLET_NAME" --recover --output json)
AKASH_ADDRESS=$(echo "$WALLET_OUTPUT" | jq -r '.address')

echo "✓ Container environment setup complete"

echo "ALLOWED PROVIDERS $TF_VAR_ALLOWED_PROVIDERS"

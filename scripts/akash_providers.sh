#!/bin/bash

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
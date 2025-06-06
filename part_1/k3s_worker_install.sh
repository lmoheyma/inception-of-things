#!/bin/bash

# Verify if token exists
if [ ! -f /vagrant_shared/node-token ]; then
    echo "[WORKER] Error: Token not found"
    exit 1
fi

# Server IP
SERVER_IP=$1

# Get token generated by the server
CLUSTER_TOKEN=$(cat /vagrant_shared/node-token)

# Install K3S (node mode)
curl -sfL https://get.k3s.io | K3S_URL="https://$SERVER_IP:6443" K3S_TOKEN="$CLUSTER_TOKEN" INSTALL_K3S_EXEC="agent --node-ip=192.168.56.111" sh -
echo "[WORKER] Worker K3S deployed"

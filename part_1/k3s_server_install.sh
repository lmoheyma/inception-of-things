#!/bin/bash

# Install K3S (server mode)
echo "[SERVER] Deployment of K3S server..."
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=192.168.56.110" sh -

# Save token
mkdir -p /home/vagrant/srcs
cp /var/lib/rancher/k3s/server/node-token /vagrant_shared/node-token

echo "[SERVER] Serveur K3s deployed..."

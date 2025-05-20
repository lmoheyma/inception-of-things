#!/bin/bash

SERVER_IP=$1

echo "[WORKER] Déploiement du nœud worker K3s..."

if [ ! -f /vagrant/k3s_token ]; then
    echo "[WORKER] Erreur: Token K3s non trouvé. Assurez-vous que le serveur a été configuré en premier."
    exit 1
fi

CLUSTER_TOKEN=$(cat /vagrant/k3s_token)

curl -sfL https://get.k3s.io | K3S_URL="https://${SERVER_IP}:6443" K3S_TOKEN="${CLUSTER_TOKEN}" INSTALL_K3S_EXEC="agent --node-ip=192.168.56.111 --flannel-iface=eth1" sh -

echo "[WORKER] Installation du nœud worker K3s terminée!"
echo "[WORKER] Ce nœud est maintenant connecté au serveur à l'adresse ${SERVER_IP}"
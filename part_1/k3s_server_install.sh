#!/bin/bash

echo "[SERVER] Déploiement du nœud serveur K3s..."

CLUSTER_TOKEN=$(openssl rand -hex 16)
echo $CLUSTER_TOKEN > /vagrant/k3s_token

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --token=${CLUSTER_TOKEN} --node-ip=192.168.56.110 --bind-address=192.168.56.110 --advertise-address=192.168.56.110 --flannel-iface=eth1 --disable=traefik --write-kubeconfig-mode=644" sh -

echo "[SERVER] Attente du démarrage de K3s..."
sleep 10

mkdir -p /vagrant/.kube
cp /etc/rancher/k3s/k3s.yaml /vagrant/.kube/config
sed -i 's/127.0.0.1/192.168.56.110/g' /vagrant/.kube/config

echo "[SERVER] Installation du nœud serveur K3s terminée!"
echo "[SERVER] Voici le token à utiliser pour vos workers:"
echo $CLUSTER_TOKEN
echo "[SERVER] Vous pouvez accéder au cluster avec 'kubectl --kubeconfig=/vagrant/.kube/config get nodes'"

kubectl --kubeconfig=/etc/rancher/k3s/k3s.yaml get nodes
#!/bin/bash

# Install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Create cluser
k3d cluster create --config /vagrant/config/k3d_cluster.yaml

# Create first namespace (Argo CD)
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Create second namespace (dev)
kubectl create namespace dev
kubectl apply -n dev -f /vagrant/config/deployment.yaml

# Port forward
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
kubectl port-forward svc/argocd-server -n argocd 8080:443 &

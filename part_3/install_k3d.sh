#!/bin/bash

# Install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Argo CD CLI
VERSION=$(curl -L -s https://raw.githubusercontent.com/argoproj/argo-cd/stable/VERSION)
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/v$VERSION/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Create cluser
k3d cluster create --config /vagrant/config/k3d_cluster.yaml

# Create first namespace (Argo CD)
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Create second namespace (dev)
kubectl create namespace dev
kubectl apply -n dev -f /vagrant/config/deployment.yaml

# Port forward
kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0 &
kubectl port-forward svc/simple-app -n dev 8081:80 --address 0.0.0.0 &

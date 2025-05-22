#!/bin/bash

# App Deployment
echo "[SERVER] Apps deployment..."

docker build -t app-one:local /vagrant/apps/app-one
docker build -t app-two:local /vagrant/apps/app-two
docker build -t app-three:local /vagrant/apps/app-three

docker save app-one:local -o /tmp/app-one.tar
k3s ctr images import /tmp/app-one.tar

docker save app-two:local -o /tmp/app-two.tar
k3s ctr images import /tmp/app-two.tar

docker save app-three:local -o /tmp/app-three.tar
k3s ctr images import /tmp/app-three.tar

kubectl apply -f /vagrant/config/app-one.yaml
kubectl apply -f /vagrant/config/app-two.yaml
kubectl apply -f /vagrant/config/app-three.yaml
kubectl apply -f /vagrant/config/ingress.yaml

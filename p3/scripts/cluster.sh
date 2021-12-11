#!/usr/bin/env bash

# cluster
k3d cluster create mycluster --servers 1 --agents 0 -p "80:80@loadbalancer" -p "443:443@loadbalancer" -p "6443:6443@loadbalancer"

# namespace
kubectl create namespace argocd
kubectl create namespace dev

# 
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# for an IngressRoute type
kubectl wait --for=condition=complete --timeout=300s -n kube-system job.batch/helm-install-traefik-crd
sleep 3
kubectl apply -f /vagrant/confs/argocd-ingressroutetcp.yaml
kubectl apply -f /vagrant/confs/playground.yaml

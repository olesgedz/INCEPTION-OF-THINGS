#!/bin/bash

kubectl apply -f /vagrant/confs/app-one.yaml
kubectl apply -f /vagrant/confs/app-two.yaml
kubectl apply -f /vagrant/confs/app-three.yaml
# for an IngressRoute type
kubectl wait --for=condition=complete --timeout=300s -n kube-system job.batch/helm-install-traefik-crd
sleep 3
kubectl apply -f /vagrant/confs/ingressroute.yaml

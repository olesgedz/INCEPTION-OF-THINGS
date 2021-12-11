#!/bin/bash

# Turn off firewalld
sudo systemctl disable firewalld.service --now

# Disable swap
sudo swapoff -a
sudo sed -i 's/^\(.*swap.*\)$/#\1/' /etc/fstab

# Install k3s
export INSTALL_K3S_EXEC="--node-ip=$NODE_IP"
export K3S_KUBECONFIG_MODE="644"

curl -sfL https://get.k3s.io | sh -

# Completion
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'alias k=kubectl' >> ~/.bashrc
echo 'complete -F __start_kubectl k' >> ~/.bashrc

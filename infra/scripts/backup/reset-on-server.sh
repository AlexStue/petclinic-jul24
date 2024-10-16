#!/bin/bash
# This script deploys the application on the server
# In DEV-environment (namespace)
# 
# - Enable error handling: the script will exit on any command failure
# - Function to handle apt-get lock if apt-get is already running automaticaly by the Server
# - Handle apt-get lock
# - Download Terraform
# - Install Terraform
# - Check if Repo already exists and clone or update the repository
# - Navigate to the Terraform directory and initialize terraform
# - Define the workspace in terraform
# - Check if the workspace exists
# - Apply terraform and therefor start the scripts in /terraform
# 

# Enable error handling: the script will exit on any command failure
set -e

# Function to handle apt-get lock if apt-get is already running automaticaly by the Server
handle_lock() {
  local lock_file=$1
  local retries=10
  local wait_time=10  # in seconds

  while [ $retries -gt 0 ]; do
    if sudo lsof $lock_file; then
      echo "Lock file $lock_file is held by another process. Retrying in $wait_time seconds..."
      sleep $wait_time
      retries=$((retries - 1))
    else
      return 0
    fi
  done

  echo "Failed to acquire lock after multiple retries. Exiting."
  exit 1
}
# Handle apt-get lock
handle_lock "/var/lib/dpkg/lock-frontend"


# CleanUp
sudo apt-get update
cd
sudo rm -r petclinic-jul24 || true # allowed to fail
kubectl delete namespace dev || true


# Download & install k3s
sudo apt-get install -y curl
curl -sfL https://get.k3s.io | sh -
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
sudo chmod 644 ~/.kube/config
sudo chmod 644 /etc/rancher/k3s/k3s.yaml


# Download & install Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"
sudo apt-get update
sudo apt-get install -y terraform


# Create Secrets






# After this, your application should be up and running on the server.
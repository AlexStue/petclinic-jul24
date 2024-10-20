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


# Download  & install K3s
# Destroy K3s 
kubectl delete namespace dev --ignore-not-found
kubectl delete namespace staging --ignore-not-found
# Install K3s
sudo apt-get update -y
sudo apt-get install -y curl
curl -sfL https://get.k3s.io | sh -
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
sudo chmod 644 ~/.kube/config
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
sudo chown ubuntu:ubuntu /etc/rancher/k3s/k3s.yaml
# Create namespace
kubectl create namespace dev


# Download  & install Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"
sudo apt-get update
sudo apt-get install -y terraform


# Check if Repo already exists and clone or update the repository
REPO_URL="https://github.com/AlexStue/petclinic-jul24.git"
DIR_NAME="petclinic-jul24"
DEFAULT_BRANCH="dev-branch"

if [ -d "$DIR_NAME" ]; then
  echo "Directory $DIR_NAME already exists. Pulling the latest changes from $DEFAULT_BRANCH ..."
  cd "$DIR_NAME" || exit
  sudo git pull origin "$DEFAULT_BRANCH"
else
  echo "Directory $DIR_NAME does not exist. Cloning the repository..."
  sudo git clone --branch "$DEFAULT_BRANCH" "$REPO_URL"
fi


# Navigate to the Terraform directory and initialize terraform
cd /home/ubuntu/petclinic-jul24/infra/terraform
terraform init

# Define the workspace in terraform
WORKSPACE_NAME="dev"
# Check if the workspace exists
if terraform workspace list | grep -q "$WORKSPACE_NAME"; then
    echo "Workspace '$WORKSPACE_NAME' already exists. Switching to it."
    terraform workspace select "$WORKSPACE_NAME"
else
    echo "Creating workspace '$WORKSPACE_NAME'."
    terraform workspace new "$WORKSPACE_NAME"
fi

# Apply terraform and therefor start the scripts in /terraform
terraform apply -auto-approve

# After this, your application should be up and running on the server.
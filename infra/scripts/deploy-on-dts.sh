#!/bin/bash
# This script deploys the application on the remote server

# Enable error handling: the script will exit on any command failure
set -e

# Function to handle apt-get lock
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

# Step 1: Install Terraform on the remote server
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"

# Handle apt-get lock
handle_lock "/var/lib/dpkg/lock-frontend"

sudo apt-get update
sudo apt-get install -y terraform

# Step 2: Clone the repository containing the Terraform code
REPO_URL="https://github.com/AlexStue/petclinic-jul24.git"
DIR_NAME="petclinic-jul24"

if [ -d "$DIR_NAME" ]; then
  echo "Directory $DIR_NAME already exists. Pulling the latest changes from "prod-branch-main" ..."
  cd "$DIR_NAME" || exit
  git pull origin prod-branch-main
else
  echo "Directory $DIR_NAME does not exist. Cloning the repository..."
  git clone "$REPO_URL"
fi

REPO_URL="https://github.com/AlexStue/petclinic-jul24.git"
DIR_NAME="petclinic-jul24"
DEFAULT_BRANCH="prod-branch-main"

if [ -d "$DIR_NAME" ]; then
  echo "Directory $DIR_NAME already exists. Pulling the latest changes from $DEFAULT_BRANCH ..."
  cd "$DIR_NAME" || exit
  git pull origin "$DEFAULT_BRANCH"
else
  echo "Directory $DIR_NAME does not exist. Cloning the repository..."
  git clone "$REPO_URL"
fi

# Step 3: Navigate to the Terraform directory and deploy infrastructure
cd /home/ubuntu/petclinic-jul24/infra/terraform
terraform init
terraform plan
terraform apply -auto-approve

# After this, your application should be up and running on the server.
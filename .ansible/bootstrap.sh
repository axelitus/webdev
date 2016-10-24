#!/bin/bash

# Updating and preparing system for ansible
sudo apt-get update && sudo apt-get install -y python

# Cleanup the ansible roles folder
echo "Cleaning ansible roles folder..."
rm -rf ./.ansible/roles

# Install required roles from roles.yml file
echo "Installing ansible roles to provision with vagrant..."
ansible-galaxy install --roles-path ./.ansible/roles -r ./.ansible/roles.yml
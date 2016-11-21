#!/bin/bash

# Updating and preparing system for latest ansible
sudo add-apt-repository ppa:ansible/ansible
sudo apt-get update && sudo apt-get install -y python ansible

# Display available ansible version
echo "Ansible version available: `ansible --version`"

# Cleanup the ansible roles folder
echo "Cleaning ansible roles folder..."
rm -rf /vagrant/.ansible/roles

# Install required roles from roles.yml file
echo "Installing ansible roles to provision with vagrant..."
ansible-galaxy install --roles-path /vagrant/.ansible/roles -r /vagrant/.ansible/roles.yml
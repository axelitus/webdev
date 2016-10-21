#!/bin/bash
# Install required roles from roles.yml file
ansible-galaxy install --roles-path ./.ansible/roles -r ./.ansible/roles.yml

# Remove this setup script
echo "Removing setup script..."
rm ./setup.sh

# Load virtual machine to provision with vagrant
echo "Vagrant up!"
vagrant up
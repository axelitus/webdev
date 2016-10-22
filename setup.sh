#!/bin/bash

# If not a repo then make it a repo
if [ ! -d "./.git" ]; then
	# Initialize git repo
	git init

	# Cleanup README file
	rm README.md && touch README.md

	# Add README file and execute first commit
git add README.md && git commit -m "First commit"

fi

# Install required roles from roles.yml file
ansible-galaxy install --roles-path ./.ansible/roles -r ./.ansible/roles.yml

# If an argument was given install the requested framework through composer
frmwrk=$1
version=$2
cmd=""

if [ "$frmwrk" != "" ]; then
	if [ "$frmwrk" == "laravel" ]; then
		cmd="composer create-project --prefer-dist laravel/laravel"
	elif [ "$frmwrk" == "fuel" ]; then
		cmd="composer create-project --prefer-dist fuel/fuel"
	fi

	# If we found a supported framework then finish the command and execute it
	if [ "$cmd" != "" ]; then
		# If we have a specific version append it to the command
		if [ "$version" != "" ]; then
			cmd=$cmd":${version}"
		fi
		# Set the command destination folder
		cmd=$cmd" src"

		# To install a framework we need to have an empty src folder
		rm -rf src/public

		# Execute framework command
		#eval $cmd
		echo "Running: $cmd"
		eval $cmd
	else
		echo "Unsupported framework, no changes made..."
	fi
fi

# Remove this setup script
echo "Removing setup script..."
rm ./setup.sh

# Load virtual machine to provision with vagrant
echo "Vagrant up!"
vagrant up
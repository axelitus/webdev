#!/bin/bash

# If not a repo then make it a repo
if [ ! -d "./.git" ]; then
	echo "Setting up git..."

	# Initialize git repo
	git init

	# Cleanup README and LICENSE file
	rm README.md LICENSE.md && touch README.md

	# Commit the core files
	git add README.md .gitignore Vagrantfile .ansible && git commit -m "First commit"
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
		rm -rf src/.gitkeep

		# Execute framework command
		#eval $cmd
		echo "Running command: $cmd"
		eval $cmd

		echo "Committing framework files..."
		git add src && git commit -m "Added framework ${frmwrk}"
	else
		echo "Unsupported framework, no changes made..."
	fi
fi

# Remove this setup script
echo "Removing setup script..."
rm ./setup.sh

# Load virtual machine to provision with vagrant
echo "Vagrant up..."
vagrant up

echo "Finished!"
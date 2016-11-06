#!/bin/bash

# Do git folder cleanup
if [ -d "./.git" ]; then
	rm -rf ./.git
fi

# Create new git repo and add first files
echo "Setting up git..."

# Initialize git repo
git init

# Cleanup README and LICENSE file
rm -f README.md LICENSE.md && touch README.md

# Commit the core files
git add README.md .gitignore Vagrantfile .ansible && git commit -m "First commit"


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
		echo "Installing framework running command: $cmd"
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

echo "WebDev Finished!"
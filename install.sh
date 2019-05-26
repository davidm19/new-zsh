#!/bin/bash

# If curl/zsh don't exist, prompt user and exit with fail status
if [[ $(which curl) == "" ]]; then
	echo "ERROR: curl is needed to complete the installation of this zshrc. Exiting..."
	exit 1
fi

if [[ ! -e "/usr/bin/zsh" ]] || [[ ! -e "/usr/local/bin/zsh" ]]; then
	echo "ERROR: zsh is needed to complete the installation of this zshrc. Exiting..."
	exit 1
fi

# Copy new zshrc to to the user's home directory
cp zshrc ~/.zshrc

# Change current user's shell
chsh -s $(which zsh)

# Ta-da.
echo "Done creating new zsh environment. Be sure to logout out of and log back into your terminal."

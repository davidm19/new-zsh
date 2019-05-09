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

# Download necessary files and create necessary locations
curl -o $HOME/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl -o $HOME/.git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

if [[ ! -d "$HOME/.zsh/" ]]; then
	mkdir $HOME/.zsh
fi

if [[ ! -d "$HOME/.zsh/_git" ]]; then
	mkdir $HOME/.zsh/_git
fi

cp $HOME/.git-completion.zsh $HOME/.zsh/_git

# Change current user's shell
chsh -s $(which zsh)

# Ta-da.
echo "Done creating new zsh environment. Be sure to logout out of and log back into your terminal."

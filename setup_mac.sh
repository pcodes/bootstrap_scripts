#!/bin/bash

function install_homebrew {
	if ! command -v brew &>/dev/null; then
		echo "Installing homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	else
		echo "Homebrew already installed, continuing..."
	fi
}

function install_homebrew_packages {
	core_packages=("fzf" "gh" "jq" "lsd" "neofetch" "neovim" "poetry" "rustup-init" "font-fira-code-nerd-font" "figlet")
	cask_packages=("1password" "1password-cli" "alfred" "bartender" "fantastical" "firefox" "kitty" "nextcloud" "obsidian" "rectangle" "slack" "spotify" "todoist")

	echo "Installing core homebrew packages..."
	for package in ${packages[@]}; do
		brew install $package
	done

	echo "Installing homebrew casks..."
	for package in ${cask_packages[@]}; do
		brew install $package
	done
}

function install_rust {
	if ! command -v cargo &>/dev/null; then
		figlet "Rust"
		echo "Running rustup installer..."
		rustup-init
	else
		echo "Rust already installed, skipping..."
	fi
}

function setup_dotfiles {
	figlet "Dotfiles"
	echo "Initializing chezmoi..."
	chezmoi init --apply pcodes
}

function open_casks {
	full_cask_names=("1Password" "Alfred Preferences" "Rectangle" "Bartender 5" "Fantastical" "Obsidian")
	for cask in "${full_cask_names[@]}"; do
		open -a "${cask}"
	done
}

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

cat $SCRIPT_DIR/mac.txt

echo "Installing homebrew..."
install_homebrew

# echo "Installing homebrew packages..."
# install_homebrew_packages

echo "Configuring dotfiles..."
setup_dotfiles

echo "Configuring rust..."
install_rust

echo "Opening apps (for full setup)..."
open_casks

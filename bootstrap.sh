# Clone this repo
# Check which OS this is
# Run correct script
echo "It's bootstrapping time...\n"

if ! command -v git &>/dev/null; then
	echo "ERROR: git is not installed, please install via your system package manager and re-run this script"
fi

echo "Cloning bootstrap repo to ~/Code/bootstrap_scripts...\n"
mkdir -p ~/Code/bootstrap_scripts

git clone https://github.com/pcodes/bootstrap_scripts.git ~/Code/bootstrap_scripts

echo "------------------------------------------------------"

if [[ "$OSTYPE" == "darwin"* ]]; then
	/bin/sh ~/Code/bootstrap_scripts/setup_mac.sh
else
	echo "No setup script implemented for your OS, sorry :("
fi

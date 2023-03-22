#!/bin/bash
# Description: This script installs the necessary packages for a new macos machine
# How to use: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Tocseoj/tocseoj/macos-init.sh)"

echo " this script will install the necessary packages for a new macOS machine"
read -p " would you like to continue? (Y/n) " -r promptResponse
promptResponse=${promptResponse:-Y}
if [[ ! "$promptResponse" =~ ^[Yy]$ ]]; then
  echo " aborting..."
  exit
fi

# check if xcode command line tools are installed
if ! xcode-select -p &> /dev/null; then
  echo " xcode command line tools are not installed, installing..."
  xcode-select --install
fi

# check if homebrew is installed
if ! command -v brew &> /dev/null; then
  echo " homebrew is not installed, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# download Brewfile
if [ -f ./Brewfile ]; then
    read -p " Brewfile already exists in this directory, would you like to overwrite it? (y/N) " -r overwriteResponse
    overwriteResponse=${overwriteResponse:-N}
    if [[ ! "$overwriteResponse" =~ ^[Yy]$ ]]; then
      echo " did not overwrite existing Brewfile, aborting..."
      exit
    fi
fi

# Always get the latest version of the Brewfile
echo " downloading Brewfile..."
curl -fsSL https://raw.githubusercontent.com/Tocseoj/tocseoj/main/Brewfile > ./Brewfile || exit

# install bundle (needs testing)
brew tap Homebrew/bundle
brew bundle

echo " done!"
exit

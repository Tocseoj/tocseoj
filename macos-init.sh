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
  read -p " was the installation successful? (Y/n) " -r promptResponse
  promptResponse=${promptResponse:-Y}
  if [[ ! "$promptResponse" =~ ^[Yy]$ ]]; then
    echo " aborting..."
    exit
  fi
fi

# check if homebrew is installed
if ! command -v brew &> /dev/null; then
  echo " homebrew is not installed, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# download our Brewfile
if [ -f ~/.Brewfile ]; then
  read -p " ~/.Brewfile already exists, would you like to get the newest version? (Y/n) " -r getBrewfile
fi
getBrewfile=${getBrewfile:-Y}
if [[ "$getBrewfile" =~ ^[Yy]$ ]]; then
  echo " downloading .Brewfile..."
  curl -fsSL https://raw.githubusercontent.com/Tocseoj/tocseoj/main/Brewfile > ~/.Brewfile || exit
fi

# install bundle (needs testing)
brew tap Homebrew/bundle
brew bundle --global

# download our zshrc
if [ -f ~/.zshrc ]; then
  read -p " ~/.zshrc already exists, would you like to get the newest version? (Y/n) " -r getZshrc
fi
getZshrc=${getZshrc:-Y}
if [[ "$getZshrc" =~ ^[Yy]$ ]]; then
  echo " downloading .zshrc..."
  curl -fsSL https://raw.githubusercontent.com/Tocseoj/tocseoj/main/zshrc > ~/.zshrc || exit
fi

# fresh oh-my-zsh install; while keeping zshrc
# ask if we should reinstall oh-my-zsh
if [ -d ~/.oh-my-zsh ]; then
  echo " ~/.oh-my-zsh already exists, re-installing will remove any changes in ~/.oh-my-zsh/custom"
  read -p " Would you like to reinstall?  (y/N)  " -r installOhMyZsh
fi
installOhMyZsh=${installOhMyZsh:-N}
if [[ "$installOhMyZsh" =~ ^[Yy]$ ]]; then
  echo " installing oh-my-zsh..."
  rm -rf ~/.oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
fi

echo " done!"
exit

###
# Personal Configurations
###

#  hammerspoon config
#  jumpcut config
#  karabiner elements config
#  iterm2 config
#  zsh config (ZSH_THEME="strug")
#  vscode config (`code` cli command)
#  chrome config
#  firefox config
#  tower config
#  1password config
# [] keyboard clean tool
# [] insomnia
# [] sequel ace?
# [] bbedit?
# OnyX
# - Screenshot > Path > /Users/jmarshall/Pictures/Screenshots/
# - Finder > Show Hidden Files
# - Desktop Image
# - Safari > Show Develop Menu
# - Profile Files???
# osx config
# - Dark Mode
# - Control Bar has lock button
# - Hey Siri is off
# - Dock > Hiding
# - Default Browser > Chrome
# - Don't rearrange spaces based on most recent use
# - (the rest should come from iCloud?)

###
# Work Setup
###

#  virtualbox
#  vagrant config
#  docker config
#  slack
# [] microsoft remote desktop
# [] Filezilla
# [] dymo?

###
# Non-work Setup
###

# [] discord
# [] gimp
# [] steam
# [] chrome remote desktop

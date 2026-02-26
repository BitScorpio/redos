#!/usr/bin/env bash
set -e

if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [ "$ID" = "nixos" ]; then
    echo "NixOS detected, proceeding with installation."
    echo "-----"
  else
    echo "This is not NixOS or the distribution information is not available."
    exit 1
  fi
else
  echo "This is not NixOS or the distribution information is not available."
  exit 1
fi

if command -v git &> /dev/null; then
  echo "Git is installed, continuing with installation."
  echo "-----"
else
  echo "Git is not installed. Please install Git and try again."
  echo "Example: nix-shell -p git"
  exit 1
fi

echo "Default options are in brackets []"
echo "Just press enter to select the default"
sleep 2

echo "-----"

echo "Ensure In Home Directory"
cd || exit

echo "-----"


echo "Cloning & Entering RedOs Repository"

git clone git@github.com:0perand9/redos.git
cd redos || exit
git config --global user.name "0perand9"
git config --global user.email "0perand9@gmail.com"


echo "Setting Required Nix Settings Then Going To Install"
NIX_CONFIG="experimental-features = nix-command flakes"

echo "-----"

sudo nixos-rebuild switch --flake ~/redos/.#nvidia
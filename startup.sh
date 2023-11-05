#!/bin/bash
# This is a startup script to install packages

# Update the package list
apt update

# Define the packages you want to install as a list
packages=(ssh icmp mtr traceroute telnet git python3 ansible vim)

# Loop through the packages and install them
for package in "${packages[@]}"; do
  # Check if the package is already installed
  if dpkg -s "$package" &> /dev/null; then
    echo "Package $package is already installed, skipping it"
  else
    echo "Package $package is not installed, installing it"
    sudo apt install "$package" -y
    # Check if the installation was successful
    if [ $? -eq 0 ]; then
      echo "Successfully installed $package"
    else
      echo "Failed to install $package"
      exit 1
    fi
  fi
done

exit 0

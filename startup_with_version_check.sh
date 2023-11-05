#!/bin/bash
# This is a startup script to install packages with specific versions

apt update

# Define the packages and versions you want to install as a list
packages=(ssh icmp mtr traceroute telnet git python3 vim curl wget net-tools jq tree zip unzip tar ca-certificates gnupg)

# Loop through the packages and install them
for package in "${packages[@]}"; do
  # Get the intended package name and version from the list element
  name=${package%=*}
  version=${package#*=}
  # Check if the package is already installed
  if dpkg -s "$name" &> /dev/null; then
    current_version=$(dpkg -s "$name" | grep Version | cut -d " " -f 2) # Get the currently installed version of the package
    # Compare the current version with the intended version
    if [ "$current_version" == "$version" ]; then
      echo "Package $name is already installed with version $current_version"
    else
      echo "Package $name is installed with version $current_version, updating to $version"
      sudo apt install --only-upgrade "$package"
      # Check if the installation was successful
      if [ $? -eq 0 ]; then
        echo "Successfully updated $name from $current_version to $version"
      else
        echo "Failed to update $name from $current_version to $version"
      fi
    fi
  else
    echo "Package $name is not installed, installing version $version"
    sudo apt install "$package"
    # Check if the installation was successful
    if [ $? -eq 0 ]; then
      echo "Successfully installed $name version $version"
    else
      echo "Failed to install $name version $version"
    fi
  fi
done

exit 0

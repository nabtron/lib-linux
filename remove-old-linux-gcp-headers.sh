#!/bin/bash

# Get the currently running kernel version
current_kernel=$(uname -r)

# List installed linux-gcp-headers packages
installed_headers=$(dpkg -l | grep 'linux-gcp-headers' | awk '{print $2}')

# Loop through the installed headers and remove older versions
for header_package in $installed_headers; do
    # Extract the version number from the package name
    version=$(echo $header_package | awk -F '-' '{print $4}')
    
    # Compare the version with the currently running kernel
    if dpkg --compare-versions "$version" lt "$current_kernel"; then
        echo "Removing $header_package"
        sudo apt-get remove -y $header_package
    fi
done

# Remove unused dependencies
sudo apt-get autoremove -y

#!/bin/bash

# Installs Rosetta as needed on Apple Silicon Macs.

exitcode=0

# Determine OS version
# Save current IFS state

OLDIFS=$IFS

IFS='.' read osvers_major osvers_minor osvers_dot_version <<< "$(/usr/bin/sw_vers -productVersion)"

# restore IFS to previous state

IFS=$OLDIFS

# Check to see if the Mac is reporting itself as running macOS 11

if [[ ${osvers_major} -ge 11 ]]; then

  # Check to see if the Mac needs Rosetta installed by testing the processor

  processor=$(/usr/sbin/sysctl -n machdep.cpu.brand_string | grep -o "Intel")
  
  if [[ -n "$processor" ]]; then
    echo "$processor processor installed. No need to install Rosetta."
  else

    # Check for Rosetta "oahd" process. If not found,
    # perform a non-interactive install of Rosetta.
    
    if /usr/bin/pgrep oahd >/dev/null 2>&1; then
        echo "Rosetta is already installed and running. Nothing to do."
    else
        /usr/sbin/softwareupdate --install-rosetta --agree-to-license
       
        if [[ $? -eq 0 ]]; then
        	echo "Rosetta has been successfully installed."
        else
        	echo "Rosetta installation failed!"
        	exitcode=1
        fi
    fi
  fi
  else
    echo "Mac is running macOS $osvers_major.$osvers_minor.$osvers_dot_version."
    echo "No need to install Rosetta on this version of macOS."
fi

exit $exitcode
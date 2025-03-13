#!/bin/bash


# this is the full URL
url="http://storage.googleapis.com/dialpad_native/osx/dialpad_dist.pkg"

# change directory to /private/tmp to make this the working directory
cd /private/tmp/

# download the installer package and name it for the linkID
/usr/bin/curl -JL "$url" -o "dialpad_dist.pkg"

# install the package
/usr/sbin/installer -pkg "dialpad_dist.pkg" -target /

# remove the installer package when done
/bin/rm -f "dialpad_dist.pkg"

exit 0

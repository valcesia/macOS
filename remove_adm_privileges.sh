#!/bin/bash

loggedInUser=`/usr/bin/stat -f%Su /dev/console`

if [ "$CurrentUser" == "root"  ] || [ "$CurrentUser" == "vmware" ] ; then
  exit 0
fi

#removes user from the admin group (post-uninstall)
dseditgroup -o edit -d "$loggedInUser" -t user admin
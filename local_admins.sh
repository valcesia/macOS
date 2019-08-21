#!/bin/bash

admins=$(/usr/bin/dscl . -read /Groups/admin GroupMembership | /usr/bin/cut -c 18-)

echo $admins

for LocalAdmin in "${admins[@]}"
do
	sudo dscl . -passwd /Users/"$LocalAdmin" OLD_PASSWORD NEW_PASSWORD
done

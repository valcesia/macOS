#!/bin/bash

group=admin;
for i in $(dscl . list /users);
do 
	[[ $(id -nG $i | grep $group) ]] && dscl . -passwd /Users/"$i" OLD_PASSWORD NEW_PASSWORD!;
done
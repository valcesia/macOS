# Sets the computer up for an authenticated restart using a temp account
/usr/bin/fdesetup authrestart -delayminutes -1 -verbose -inputplist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Username</key>
	<string>"$currUser"</string>
	<key>Password</key>
	<string>"$fvPass"</string>
</dict>
</plist>
EOF

# Runs the startosinstall binary to start the upgrade
"/Applications/Install macOS Mojave.app/Contents/Resources/startosinstall" --applicationpath "/Applications/Install macOS Mojave.app" --rebootdelay 0 --nointeraction --agreetolicense

# Pulls the current user
currUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk -F': ' '/[[:space:]]+Name[[:space:]]:/ { if ( $2 != "loginwindow" ) { print $2 }}')
currUserUID=$(id -u "$currUser")

# Kills self service to allow the installer to continue with the update
/bin/launchctl asuser "$currUserUID" sudo -iu "$currUser" killall "Self Service"

# Exits the script
exit 0

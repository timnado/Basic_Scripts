#!/bin/bash
####################################################################################################
#
# This will disconnect a user from a wireless network you do not want them on
#
############################################################

#####THIS SCRIPT IS DESIGNED FOR 10.7 and higher!!!!!!!!!!!!!!!

####Variables

########SSID Variable

#########SSID that we want removed
ssid="badssid"




####################do not Modify below this line ###############################################################

######GUID
guidid=`ioreg -rd1 -c IOPlatformExpertDevice | awk '/IOPlatformUUID/ { split($0, line, "\""); printf("%s\n", line[4]); }'`

####Look for Which Port is Wi-Fi
wifiprt=`/usr/sbin/networksetup -listallhardwareports | grep -A 1 Wi-Fi | grep Device | awk '{print $2}'`

######Get logged in user
loggedInUser=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`




###########Remove Guest Network from perferred network
sudo networksetup -removepreferredwirelessnetwork $wifiprt $ssid



##### Turn off Wireless
sudo networksetup -setairportpower $wifiprt off



##### Turn Wireless back on
sudo networksetup -setairportpower $wifiprt on

#######kill password Saved from Keychain
sudo security delete-generic-password -l $ssid "/Library/Keychains/System.keychain"


############kill Local Items keychain that holds password, it is used for icloud and should come back down if icloud needs it
sudo rm -r /Users/$loggedInUser/Library/Keychains/$guidid





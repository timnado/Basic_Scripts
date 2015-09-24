#!/bin/bash
####################################################################################################
#
#
##############
#Script for setting Wireless Settings and connecting.
#
#
############################################################

#####THIS SCRIPT IS DESIGNED FOR 10.7 and higher!!!!!!!!!!!!!!!

####Variables

###Variable for Preference File
guidid=`/usr/libexec/PlistBuddy -c "print :Sets:" /Library/Preferences/SystemConfiguration/preferences.plist | grep - |  awk 'NR==1' | awk '{print $1}'`


####Look for Which Port is Wi-Fi
wifiprt=`/usr/sbin/networksetup -listallhardwareports | grep -A 1 Wi-Fi | grep Device | awk '{print $2}'`

#####SSID for Network
#SSID=""	 

#####Wireless Password for SSID above
#password=""	 

#####Removes the option for Asking to join networks
/usr/libexec/PlistBuddy -c "Delete :Sets:"$guidid":Network:Interface:"$wifiprt":AirPort:JoinModeFallback string " /Library/Preferences/SystemConfiguration/preferences.plist
/usr/libexec/PlistBuddy -c "Add :Sets:"$guidid":Network:Interface:"$wifiprt":AirPort:JoinModeFallback array string DoNothing" /Library/Preferences/SystemConfiguration/preferences.plist

######## Setting to remember Joined Network
/usr/libexec/PlistBuddy -c "Set :Sets:"$guidid":Network:Interface:"$wifiprt":AirPort:RememberJoinedNetworks true" /Library/Preferences/SystemConfiguration/preferences.plist

#### setting to Require Admin Computer to computer Network
/usr/libexec/PlistBuddy -c "Set :Sets:"$guidid":Network:Interface:"$wifiprt":AirPort:RequireAdminIBSS true" /Library/Preferences/SystemConfiguration/preferences.plist

##### Require Admin Rights to change networks
/usr/libexec/PlistBuddy -c "Set :Sets:"$guidid":Network:Interface:"$wifiprt":AirPort:RequireAdminNetworkChange true" /Library/Preferences/SystemConfiguration/preferences.plist

#### require admin rights to turn off or on wireless network
/usr/libexec/PlistBuddy -c "Set :Sets:"$guidid":Network:Interface:"$wifiprt":AirPort:RequireAdminPowerToggle true" /Library/Preferences/SystemConfiguration/preferences.plist


########## Setting the Wireless Network to Connect above
/usr/sbin/networksetup -setairportnetwork en1 "$SSID" "$password"


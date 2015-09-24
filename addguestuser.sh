#!/bin/bash
####################################################################################################
#
# Copyright (c) 2013, JAMF Software, LLC.  All rights reserved.
#
#       Redistribution and use in source and binary forms, with or without
#       modification, are permitted provided that the following conditions are met:
#               * Redistributions of source code must retain the above copyright
#                 notice, this list of conditions and the following disclaimer.
#               * Redistributions in binary form must reproduce the above copyright
#                 notice, this list of conditions and the following disclaimer in the
#                 documentation and/or other materials provided with the distribution.
#               * Neither the name of the JAMF Software, LLC nor the
#                 names of its contributors may be used to endorse or promote products
#                 derived from this software without specific prior written permission.
#
#       THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
############################################################


#######Create the Guest User

			dscl . -create /Users/Guest
			dscl . -create /Users/Guest dsAttrTypeNative:_defaultLanguage en
			dscl . -create /Users/Guest dsAttrTypeNative:_guest true
			dscl . -create /Users/Guest dsAttrTypeNative:_writers__defaultLanguage Guest
			dscl . -create /Users/Guest dsAttrTypeNative:_writers__LinkedIdentity Guest
			dscl . -create /Users/Guest dsAttrTypeNative:_writers__UserCertificate Guest
			dscl . -create /Users/Guest AuthenticationHint ''
			dscl . -create /Users/Guest NFSHomeDirectory /Users/Guest
###it needs time or it may fail
			sleep 2
###Create Password of Nothing
			dscl . -passwd /Users/Guest ''
	###it needs time or it may fail
			sleep 2
#### Create the Unique Info if use default it won't work must be 201 user and group
			dscl . -create /Users/Guest Picture "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/UserIcon.icns"
			dscl . -create /Users/Guest PrimaryGroupID 201
			dscl . -create /Users/Guest RealName "Guest User"
			dscl . -create /Users/Guest RecordName Guest
			dscl . -create /Users/Guest UniqueID 201
			dscl . -create /Users/Guest UserShell /bin/bash
			
			###### have to add Guest User to System Keychain
			security add-generic-password -a Guest -s com.apple.loginwindow.guest-account -D "application password" /Library/Keychains/System.keychain
##### Enable Guest user in System Preferences
			defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool TRUE

####kill Login Screen to Show Guest User--Will log out a user if logged in!!!
Killall -9 loginwindow


			exit 0
		fi
	fi
}

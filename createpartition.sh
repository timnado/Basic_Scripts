
#!/bin/bash
####################################################################################################
#
# Copyright (c) 2014, JAMF Software, LLC.  All rights reserved.
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

#########How much free Gigs are needed
freegig="30"

#####size of recovery drive
revdr="16"

#############################################
#
#
#DO not Modify below this line
#
##########################################




#### tells Which disk is the HD on
devdsk=`diskutil info / | grep "Device Node" | awk '{ print $3 }'`
echo $devdsk


###### How many Gigs of Data free
frspce=`df -gH | grep "dev/" | awk '{ print $4 }' | cut -d "G" -f 1`
echo $frspce


########How big is the Hard drive
hdspce=`df -gH | grep "dev/" | awk '{ print $2 }' | cut -d "G" -f 1`
echo $hdspce

#### Equations to see if enough space and what size to make HD####################

##### making sure there is enough free space replace number with how many gigs it should have free
if [ "$frspce" -ge $freegig ]
then
echo "There is enough free space"
else  
  echo "not enough space"		###comment this out later now just for testing
  #####exit 0
fi                    

######the math to take away 15 GB for Restore Partition and variable for command to resize. the -1 is to make up for diff in actual GB size
newhd=`(expr $hdspce - $revdr - 1)`
echo $newhd
echo "test end"

######Resizing the HD this will resize the partition ##############################################################
sudo diskutil resizeVolume $devdsk $newhd"G" HFS+ "Restore" $revdr"G"

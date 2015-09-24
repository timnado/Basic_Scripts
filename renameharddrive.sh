#!/bin/bash

#####################################################
#
#
#This will rename a HardDrive back to Macintosh HD
# Used for Schools where kids change HD name often by accident
#
####################################################
export VolumeName=`diskutil info / | grep "Volume Name" | cut -c 30-`

if [ "$VolumeName" != "Macintosh HD" ];
then diskutil renameVolume "$VolumeName" "Macintosh HD"
exit 1; 
fi

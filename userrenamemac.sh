#!/bin/bash


### lets end user pick Device name, Run in JSS user doesn't need to have admin rights

ComputerName="$(osascript -e 'Tell application "System Events" to display dialog "Please Input New Computer Name Based on work standards" default answer "myname"' -e 'text returned of result' 2>/dev/null)"

jamf setComputerName -name $ComputerName

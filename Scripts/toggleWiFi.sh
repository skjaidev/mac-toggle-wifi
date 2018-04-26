#!/bin/bash
# Toggle-Wifi
#    - Disables wifi if a higher priority network interface is active
#    - Enables wifi if no other network interface is active
#
# Priority is the service order in System Preferences -> Network.
#

function notify
{
    osascript -e "display notification \"$1\" with title \"Wifi Toggle\" sound name \"Hero\""
}

function set_wifi_state
{
    device=$1
    cur_state=`/usr/sbin/networksetup -getairportpower $device | cut -d ":" -f2 | cut -b2-`
    new_state=$2
    if [ "$cur_state" != "$1" ]
    then
	/usr/sbin/networksetup -setairportpower $device $new_state
	[[ $new_state == "On" ]] && en_dis="Enabled" || en_dis="Disabled"
	echo "$en_dis Wifi"
    fi
}

found_active=0
for i in `networksetup -listnetworkserviceorder | tr -d " ) " | tr -s "," ":" | awk -F ":" '/Hardware/{print $2 "," $4}'`
do
    name=`echo $i | awk -F "," '{print $1}'`
    device=`echo $i | awk -F "," '{print $2}'`

    state="`ifconfig $device 2> /dev/null | awk '/status:/{print $2}'`"
    if [ "$state" == "active" ]
    then
	if [ $found_active -eq 0 ]
	then
	    found_active=1
	else
	    if [ $name == 'Wi-Fi' -o $name == "AirPort" ]
	    then
		notify "$(set_wifi_state $device Off)"
	    fi
	fi
    fi

done

if [ $found_active -eq 0 ]
then
    device=`networksetup -listnetworkserviceorder | sed -En 's/^\(Hardware Port: (Wi-Fi|AirPort), Device: (en.)\)$/\2/p'`
    notify "$(set_wifi_state $device On)"
fi

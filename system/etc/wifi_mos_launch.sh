#! /system/bin/sh
echo "$0 $@"

SSID=$1
IPADD=$2
ARGSNUM=$#
#BCM=`GetWiFiID | grep BCM`
#WCNSS=`GetWiFiID | grep WCN`

SSID='"'$SSID'"'
IPADD= '"'$IPADD'"'
echo "begin wifi connect"
#wpa_supplicant -Dwext -C/data/system/wpa_supplicant -c/data/misc/wifi/wpa_supplicant.conf -iwlan0
wpa_cli -iwlan0 -p /data/misc/wifi/sockets add_network 0

#if [ -n "$WCNSS" ]; then
	if ( test $ARGSNUM -lt 2 ) ; then
		echo "Too less args, please enter args!!!"
	elif ( test $ARGSNUM -eq 2 ) ; then
		echo "The $SSID network is open, are you sure without key_mgmt?"
        wpa_cli -iwlan0 -p /data/misc/wifi/sockets set_network 0 ssid $SSID;
		wpa_cli -iwlan0 -p /data/misc/wifi/sockets set_network 0 key_mgmt NONE
	else
		echo "invalid arguments"
		exit 1
	fi
	
	i=0
	wpa_cli -iwlan0 -p /data/misc/wifi/sockets enable_network 0
	STATUS=`wpa_cli -iwlan0 -p /data/misc/wifi/sockets status | busybox grep 'wpa_state=COMPLETED'`
	while [ -z "$STATUS" ] && [ "$i" != "10" ];do
		#wpa_cli -iwlan0 -p /data/misc/wifi/sockets disable_network 0
		#wpa_cli -iwlan0 -p /data/misc/wifi/sockets enable_network 0
		i=$(($i+1))
		echo "try to enable network $i"
		echo "STATUS = $STATUS"
		sleep 1
		STATUS=`wpa_cli -iwlan0 -p /data/misc/wifi/sockets status | busybox grep 'wpa_state=COMPLETED'`
	done
	
	if [ -z "$STATUS" ]; then
		echo "enable_network failed"
		exit 1
	else
		echo "enable_network success"
	fi
#fi


#i=0
#dhcpcd wlan0;
#sleep 1
#IP=`busybox ifconfig | busybox grep '192.168'`
#while [  -z "$IP" ] && [ "$i" != "10" ];do
#	echo "try grep '192.168' $i"
	#dhcpcd wlan0
#	sleep 1
#	IP=`busybox ifconfig | busybox grep '192.168'`
#	i=$(($i+1))
#done


	

i=0
busybox ifconfig wlan0 $IPADD netmask 255.255.255.0
sleep 1
while [  -z "$IP" ] && [ "$i" != "10" ];do
	#busybox ifconfig wlan0 192.168.0.103 netmask 255.255.255.0
	echo "try grep '192.168' $i"
	sleep 1
	IP=`busybox ifconfig | busybox grep '192.168'`
	i=$(($i+1))
done

if [ -z "$IP" ] ; then
	echo "not connet to ssid $SSID"
	exit 1
else
	echo "Have conneted to ssid $SSID"
	exit 0
fi

#busybox ifconfig wlan0

#echo "Have conneted to ssid $SSID,"

#diag_socket_log -a 192.168.1.2 &



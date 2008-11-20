#!/bin/sh /etc/rc.common

######################################
#									 #
# Orginal script by ben@wildblue.de  #
#									 #
######################################

###################################################################
# fon heartbeat script
#
# Description:
#
# Author(s) [in order of work date]:
#       m4rc0 <jansssenmaj@gmail.com>
#
# Major revisions:
#		Initial release 2008-11-20
#
# NVRAM variables referenced:
#       none
#
# Configuration files referenced:
#       /etc/fonheartbeat
#		/etc/fonkey
#
# Required components:
#

START=98

config_cb() {
	local cfg_type="$1"
	local cfg_name="$2"

	case "$cfg_type" in
		fonheartbeat)
			heartbeat_cfg="$cfg_name"
		;;
	esac
}


start() {
	uci_load fonheartbeat

	config_get MAC $heartbeat_cfg mac
	config_get WLMAC $heartbeat_cfg wlmac
	config_get FONREV $heartbeat_cfg fonrev
	config_get FIRMWARE $heartbeat_cfg firmware
	config_get CHILLVER $heartbeat_cfg chillver
	config_get THCLVER $heartbeat_cfg thclver
	config_get DEVICE $heartbeat_cfg device
	config_get FONKEY $heartbeat_cfg fonkey
	config_get PORT $heartbeat_cfg port
	config_get SERVER $heartbeat_cfg server
	config_get USER $heartbeat_cfg user
	config_get ENABLED $heartbeat_cfg enabled

	if [ "$ENABLED" = "1" ]; then
		echo "mode='start' wlmac='$WLMAC' mac='$MAC' fonrev='$FONREV' firmware='$FIRMWARE' chillver='$CHILLVER' thclver='$THCLVER' device='$DEVICE'" | dbclient -T -p $PORT -i $FONKEY $USER@$SERVER > /tmp/startscript
		echo "mode='cron' wlmac='$WLMAC' mac='$MAC' fonrev='$FONREV' firmware='$FIRMWARE' chillver='$CHILLVER' thclver='$THCLVER' device='$DEVICE'" | dbclient -T -p $PORT -i $FONKEY $USER@$SERVER > /tmp/newscript
	fi
	}

	
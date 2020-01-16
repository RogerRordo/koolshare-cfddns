#!/bin/sh

if [ "`dbus get cfddns_enable`" == "1" ]; then
    cru a cfddns_update "*/`dbus get cfddns_interval` * * * * /koolshare/scripts/cfddns_update.sh"
    sh /koolshare/scripts/cfddns_update.sh
else
	cru d cfddns_update
fi
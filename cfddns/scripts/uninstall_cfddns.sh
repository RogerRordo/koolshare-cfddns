#!/bin/sh
cru d cfddns_update

rm /koolshare/res/icon-cfddns.png > /dev/null 2>&1
rm /koolshare/webs/Module_cfddns.asp > /dev/null 2>&1
rm /koolshare/scripts/cfddns_config.sh > /dev/null 2>&1
rm /koolshare/scripts/cfddns_update.sh > /dev/null 2>&1
rm /koolshare/scripts/uninstall_cfddns.sh > /dev/null 2>&1

dbus remove softcenter_module_cfddns_install
dbus remove softcenter_module_cfddns_version
dbus remove softcenter_module_cfddns_description

# remove start up command
sed -i '/cfddns_config.sh/d' /jffs/scripts/wan-start >/dev/null 2>&1
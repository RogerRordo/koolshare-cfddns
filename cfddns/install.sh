#!/bin/sh

if [[ `dbus version|awk -F " " '{print $NF}'` !=  "3.0.0" ]]; then
    echo "dbus version (`dbus version|awk -F " " '{print $NF}'`) is not supported now, please contact the developer!"
    exit
fi

cp -r /tmp/cfddns/res/* /koolshare/res
cp -r /tmp/cfddns/scripts/* /koolshare/scripts
cp -r /tmp/cfddns/webs/* /koolshare/webs

chmod a+x /koolshare/scripts/cfddns_*

# add icon into softerware center
dbus set softcenter_module_cfddns_install=1
dbus set softcenter_module_cfddns_version=1.1.1
dbus set softcenter_module_cfddns_description="CloudFlare DDNS"

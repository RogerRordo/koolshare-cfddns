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
dbus set softcenter_module_cfddns_version=1.1.2
dbus set softcenter_module_cfddns_description="CloudFlare DDNS"


# Add service to auto start
if [ ! -f /jffs/scripts/wan-start ]; then
	cat > /jffs/scripts/wan-start <<-EOF
		#!/bin/sh
		dbus fire onwanstart
		
		EOF
fi

startss=$(cat /jffs/scripts/wan-start | grep "/koolshare/scripts/cfddns_config.sh")
if [ -z "$startss" ];then
	sed -i '2a sh /koolshare/scripts/cfddns_config.sh' /jffs/scripts/wan-start
fi
chmod +x /jffs/scripts/wan-start

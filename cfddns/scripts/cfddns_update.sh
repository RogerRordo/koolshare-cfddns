#!/bin/sh

eval `dbus export cfddns_`

if [ "$cfddns_enable" != "1" ]; then
    echo "not enable"
    exit
fi

now=`date`
ip=`$cfddns_curl 2>&1` || die "$ip"
current_ip=`nslookup $cfddns_name.$cfddns_domain $cfddns_dns 2>&1`

[ "$cfddns_curl" = "" ] && cfddns_curl="curl -s whatismyip.akamai.com"
[ "$cfddns_dns" = "" ] && cfddns_dns="114.114.114.114"
[ "$cfddns_ttl" = "" ] && cfddns_ttl="600"

die () {
    echo $1
    dbus ram cfddns_last_act="$now: failed($1)"
}

urlencode() {
    # urlencode <string>
    out=""
    while read -n1 c; do
        case $c in
            [a-zA-Z0-9._-]) out="$out$c" ;;
            *) out="$out`printf '%%%02X' "'$c"`" ;;
        esac
    done
    echo -n $out
}

enc() {
    echo -n "$1" | urlencode
}

update_record() {
    curl -X PUT "https://api.cloudflare.com/client/v4/zones/$cfddns_zone_id/dns_records/$cfddns_record_id" \
    -H "Content-Type:application/json" \
    -H "X-Auth-Key:$cfddns_key" \
    -H "X-Auth-Email:$cfddns_email" \
     --data "{\"type\":\"A\",\"name\":\"$cfddns_name\",\"content\":\"$ip\",\"ttl\":$cfddns_ttl}"
}


if [ "$?" -eq "0" ]; then
    current_ip=`echo "$current_ip" | grep 'Address 1' | tail -n1 | awk '{print $NF}'`

    if [ "$ip" = "$current_ip" ]; then
        echo "skipping"
        dbus set cfddns_last_act="$now: skipped($ip)"
        exit 0
    else
        echo "changing"
        update_record
        dbus set cfddns_last_act="$now: changed($ip)"
    fi 
fi


#!/bin/bash
# To sync stuff from batocera rg35xx devices
# Executing this from rg35xx batocera ports

exclude_list="
decorations/
extractions/
kodi/
library/
lost+found/
system/
"

function define_destination (){
    src=$(ifconfig | grep wlan -A1 | grep 'inet' | awk '{print $2}')
    dst=192.168.1.XXX
}

function validate_destination(){
    if [ "$src" == "$dst" ]; then
        echo "[$(date)] source ($src) and destination ($dst) seem to be the same, exiting..."
        exit 1
    fi

    ssh $dst "uptime" > /dev/null
    if [ $? != 0 ]; then
        echo "[$(date)] unable to reach $dst via ssh, exiting..."
        exit 1
    fi
}

function sync_stuff(){
    echo "[$(date)] PUSH $src -> $dst"
    rsync -avruP --exclude-from=<(echo "$exclude_list") /userdata/ $dst:/userdata/

    echo "[$(date)] PULL $src <- $dst"
    rsync -avruP --exclude-from=<(echo "$exclude_list") $dst:/userdata/ /userdata/
}

function main (){
    define_destination
    validate_destination
    sync_stuff
}

if [[ "$0" == "$BASH_SOURCE" ]]; then
    LOGFILE=$(mktemp)
    main | tee -a $LOGFILE
fi

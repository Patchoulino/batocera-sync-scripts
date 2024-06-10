#!/bin/bash
# To sync stuff from batocera rg35xx devices
# Executing this from rg35xx batocera ports

function define_destination (){
    #src=$(ifconfig wlan1 | grep 'inet ' | awk '{print $2}')
    src=$(hostname).lan
    case $src in
        rg35xx-h*)
            dst=${1:-rg35xx-sp.lan}
            ;;
        rg35xx-sp*)
            dst=${1:-rg35xx-h.lan}
            ;;
    esac
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
    local exclude_list=$(cat <<EOF
decorations/
extractions/
kodi/
library/
lost+found/
system/
EOF
)

    echo "[$(date)] PUSH $src -> $dst"
    rsync -avruP --exclude-from=<(echo "$exclude_list") /userdata/ $dst:/userdata/

    echo "[$(date)] PULL $src <- $dst"
    rsync -avruP --exclude-from=<(echo "$exclude_list") $dst:/userdata/ /userdata/
}

function main (){
    define_destination "$@"
    validate_destination
    sync_stuff
}

if [[ "$0" == "$BASH_SOURCE" ]]; then
    LOGFILE=$(mktemp)
    main "$@" | tee -a $LOGFILE
fi

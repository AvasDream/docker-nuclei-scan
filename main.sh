#!/bin/bash
toolsDir='/tools'
DOMAIN="$1"
inputfile="$2"

function notify {
    python3 /code/message.py "$1"
}

function nuclei-exec {
    nuclei -nC -l "$inputfile" -t "$toolsDir"'/nuclei/nuclei-templates/' -timeout 3 -severity low,medium,high -o "/data/nuclei-$DOMAIN.txt" &> /data/debug-nuclei-$DOMAIN.txt
    nuclei_found=$(cat "/data/nuclei-$DOMAIN.txt" | cut -d" " -f1 | sort -u )
    message=$(echo -e "$DOMAIN:\n$nuclei_found")
    notify "$message"
}

function main {
    nuclei-exec
}

{ time main ; } 2> time.txt
t=$(cat time.txt | grep real | cut -d " " -f2)
number_domains=$(cat $inputfile | wc -l)
notify "Nuclei for $DOMAIN with $number_domains subdomains in $t"


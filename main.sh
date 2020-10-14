#!/bin/bash
toolsDir='/tools'
DOMAIN="$1"
baseDir="/root/$DOMAIN"

function notify {
    python3 /code/message.py "$1"
}

notify "$1"


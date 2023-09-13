#!/usr/bin/env bash

compress_video() {
    find "${1:-"."}/" \( \
            -name "*.avi" -o \
            -name "*.flv" -o \
            -name "*.m4v" -o \
            -name "*.mov" -o \
            -name "*.wmv" -o \
            -name "*.mp4" -o \
            -name "*.MP4" -o \
            -name "*.TS" -o \
            -name "*.mkv" -o \
            -name "*.webm" \) \
        -execdir bash -c 'ffmpeg -y -i '${1:-"."}/'"$0" -hide_banner -c:v '${2:-"libx265"}' -preset '${3:-"ultrafast"}' -crf '${4:-"28"}' "/tmp/$0"' {} \; \
        -execdir bash -c 'rm '${1:-"."}/'"$0"' {} \; \
        -execdir bash -c 'mv "/tmp/$0" '${1:-"."}/'' {} \;
}

if [[ ! -d "/tmp" ]]; then
    mkdir "/tmp"
    compress_video "$@"
else
    compress_video "$@"
fi

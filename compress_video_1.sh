#!/usr/bin/env bash

compress_video() {
    find . \( \
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
        -execdir bash -c 'ffmpeg -y -i "$0" -hide_banner -c:v libx265 -preset ultrafast -crf 28 "/tmp/$0"' {} \; \
        -execdir bash -c 'rm "./$0"' {} \; \
        -execdir bash -c 'mv "/tmp/$0" .' {} \;
}

if [[ ! -d "/tmp" ]]; then
    mkdir "/tmp"
    compress_video
else
    compress_video
fi

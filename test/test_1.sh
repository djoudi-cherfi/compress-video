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
        -execdir bash -c 'echo "input: $0 output: /tmp/$0"' {} \; \
        -execdir bash -c 'echo "rm: ./$0"' {} \; \
        -execdir bash -c 'echo "mv: /tmp/$0 ./"' {} \;
}

if [[ ! -d "/tmp" ]]; then
    echo "/tmp not found"
    echo "mkdir /tmp"
    compress_video
else
    echo "/tmp found"
    compress_video
fi

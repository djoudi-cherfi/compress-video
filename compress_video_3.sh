#!/usr/bin/env bash

error_missing_argument="missing argument"

print_error_and_exit() {
    echo "Error: $1"
    exit 1
}

check_empty_argument() {
    if [[ -z $2 || $2 =~ ^-[a-zA-Z]+$ ]]; then
        print_error_and_exit "$1 $error_missing_argument"
    fi
}

help() {
    cat <<EOF
NAME:
    ${0##*/}  -   Brief description

USAGE:
    program-name.sh [ -h  | --help ]
                    [ -c | --codec ] <arg1>
                    ...

WITHOUT OPTIONS:
    codec: libx265, preset: ultrafast, quality: 28, extension: "",
    directory_path: ./, output_directory: /tmp/

OPTIONS:
    -c, --codec
        Defines the codec that should be used.
        libx264, libx265, h264, etc.
    
    -p, --preset
        Defines the preset that should be used.
        ultrafast, superfast, veryfast, faster, fast,
        medium – default, slow, slower, veryslow.
    
    -q, --quality
        Defines the quality that should be used.
        The range of the quality scale is 0–51,
        where 0 is lossless (for 8 bit only, for 10 bit use -qp 0),
        23 is the default, and 51 is worst quality possible.
    
    -e, --extension
        Defines the extension that should be used.
        avi, m4v, mov, wmv, mp4, ts, mkv, webm, etc.

    -d, --directory_path
        Sets the path of the input directory where items should be processed.
EOF
}

compress_video() {
    local codec="${codec:-libx265}"
    local preset="${preset:-ultrafast}"
    local quality="${quality:-28}"
    local extension="${extension:-}"
    local directory_path="${directory_path:-./}"
    local file_name='"$0"'
    
    if [[ $directory_path =~ \S+[^\/]+$ ]]; then
        directory_path=$directory_path/
    fi

    if [[ $extension =~ ^[^\.][a-zA-Z0-9]{0,3} ]]; then
        extension=.$extension
    fi

    if [[ -n $extension ]]; then
        file_name_extension='"${0%.*}"'$extension
    else
        file_name_extension='"$0"'
    fi

    find "$directory_path" \( \
            -name "*.avi" -o \
            -name "*.m4v" -o \
            -name "*.mov" -o \
            -name "*.wmv" -o \
            -name "*.mp4" -o \
            -name "*.ts" -o \
            -name "*.mkv" -o \
            -name "*.webm" \) \
        -execdir bash -c 'ffmpeg -y -i '$directory_path$file_name' -hide_banner -c:v '$codec' -preset '$preset' -crf '$quality' '/tmp/$file_name_extension'' {} \; \
        -execdir bash -c 'rm '$directory_path$file_name'' {} \; \
        -execdir bash -c 'mv '/tmp/$file_name_extension' '$directory_path'' {} \;
}

main() {
    while [[ $# > 0 ]]; do
        case $1 in
            -h | --help )
                help
                shift 1
                ;;
            -c | --codec )
                local option=$1
                local arg=$2
                check_empty_argument "$option" "$arg"
                codec="$arg"
                shift 2
                ;;
            -p | --preset )
                local option=$1
                local arg=$2
                check_empty_argument "$option" "$arg"
                preset="$arg"
                shift 2
                ;;
            -q | --quality ) 
                local option=$1
                local arg=$2
                check_empty_argument "$option" "$arg"
                quality="$arg"
                shift 2
                ;;
            -e | --extension ) 
                local option=$1
                local arg=$2
                check_empty_argument "$option" "$arg"
                extension="$arg"
                shift 2
                ;;
            -d | --directory_path )
                local option=$1
                local arg=$2
                check_empty_argument "$option" "$arg"
                directory_path="$arg"
                shift 2
                ;;
            *)
                print_error_and_exit "unknown option: $1. Use -h or --help for usage."
                exit 1
                ;;
        esac
    done

    compress_video
}

main "$@"

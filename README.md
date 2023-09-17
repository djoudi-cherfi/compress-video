# [compress-video](https://github.com/djoudi-cherfi/compress-video)

Author : [Djoudi Cherfi](https://github.com/djoudi-cherfi)

## Description

Bash script to compress video.

## Before running the script, check if ffmpeg is installed

```bash
    ffmpeg -version
```

Mac : homebrew

```bash
    brew update && brew upgrade
    brew install ffmpeg
```

Linux : apt

```bash
    sudo apt update && sudo apt upgrade
    sudo apt install ffmpeg
```

## Run script

**Without option**  
Default setting : codec: libx265, preset: ultrafast, quality: 28, extension: "", directory_path: ./

**With option**  
./compress_video_3.sh -c h264 -p fast -q 24 -e .mp4 -d ./directory_path

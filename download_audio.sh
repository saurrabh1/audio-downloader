#!/bin/bash

URL="$1"
OUTPUT="${2:-downloaded_audio.mp3}"

if [ -z "$URL" ]; then
  echo "Usage: ./download_audio.sh <URL> [output_filename.mp3]"
  exit 1
fi

echo "Downloading: $URL"

if [[ "$URL" =~ \.(mp3|wav|m4a|ogg|aac|opus)(\?|$) ]]; then
  curl -L "$URL" -o "$OUTPUT"
elif [[ "$URL" =~ \.m3u8(\?|$) ]]; then
  ffmpeg -i "$URL" -c:a libmp3lame -q:a 2 "$OUTPUT" -y
else
  yt-dlp -x --audio-format mp3 --audio-quality 0 -o "$OUTPUT" "$URL"
fi

echo "Done! Saved to: $OUTPUT"

#!/bin/bash

SHARE_URL="$1"
OUTPUT="${2:-$HOME/Downloads/recording_$(date +%s).mp3}"

if [ -z "$SHARE_URL" ]; then
  echo "Usage: ./download_astrotalk.sh <astrotalk-share-link> [output_filename.mp3]"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -d "$SCRIPT_DIR/node_modules" ]; then
  echo "First run — installing dependencies (one-time, ~1 min)..."
  (cd "$SCRIPT_DIR" && npm install --silent)
fi

echo "Opening: $SHARE_URL"
RECORDING_URL=$(node "$SCRIPT_DIR/extract_url.js" "$SHARE_URL")
STATUS=$?

if [ $STATUS -ne 0 ] || [ -z "$RECORDING_URL" ]; then
  echo "Could not find the recording URL on that page. It may have expired, require login, or the page structure changed."
  exit 1
fi

echo "Found recording stream, downloading..."

if [[ "$RECORDING_URL" =~ \.m3u8(\?|$) ]]; then
  ffmpeg -i "$RECORDING_URL" -c:a libmp3lame -q:a 2 "$OUTPUT" -y
else
  curl -L "$RECORDING_URL" -o "$OUTPUT"
fi

echo "Done! Saved to: $OUTPUT"

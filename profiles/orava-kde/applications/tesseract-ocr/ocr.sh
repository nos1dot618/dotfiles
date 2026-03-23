#!/usr/bin/env bash
set -xeu
exec > /tmp/ocr.log 2>&1

TMP_FILE=$(mktemp --suffix=.png)

spectacle --region --background --nonotify --output "$TMP_FILE"
TEXT=$(tesseract "$TMP_FILE" stdout --psm 6)
printf "%s" "$TEXT" | wl-copy # Copy to clipboard

rm "$TMP_FILE"

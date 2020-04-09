#!/bin/sh

# turn off screensaver
xset -dpms
xset s off
xset s noblank


# screen size
width="1280"
height="720"

# url
url="https://duckduckgo.com"

exec chromium-browser $url --window-size=$width,$height --window-position=0,0 --kiosk --no-sandbox --full-screen --incognito --noerrdialogs --disable-translate --no-first-run --fast --fast-start --ignore-gpu-blacklist --disable-quic --enable-fast-unload --enable-tcp-fast-open ---enable-native-gpu-memory-buffers --enable-gpu-rasterization --enable-zero-copy --disable-infobars --disable-features=TranslateUI --disk-cache-dir=/tmp
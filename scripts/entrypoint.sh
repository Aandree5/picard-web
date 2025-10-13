#!/bin/sh

export XDG_RUNTIME_DIR="/home/picarduser/.xdg"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

mkdir -p /home/picarduser/.xpra
chmod 700 /home/picarduser/.xpra

# Start PulseAudio in user mode
pulseaudio --start --exit-idle-time=-1 --log-level=error --disallow-exit

xpra start $XPRA_DISPLAY \
    --bind-tcp=0.0.0.0:5005 \
    --html=on \
    --exit-with-children=no \
    --mdns=no \
    --webcam=no \
    --daemon=no \
    --socket-dir="/home/picarduser/.xpra" \
    --session-name=picard-session \
    --start=picard & XPRA_PID=$!

sleep 5

while kill -0 $XPRA_PID 2>/dev/null; do
    if ! pgrep -u picarduser -x picard >/dev/null; then
        echo "Picard not running, restarting..."
        xpra control :100 start picard
    fi
    sleep 2
done
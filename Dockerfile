FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    xpra \
    python3-dbus \
    dbus-x11 \
    pulseaudio \
    pulseaudio-utils \
    python3-pyqt5 \
    python3-pyinotify \
    python3-xdg \
    xauth \
    ffmpeg \
    picard \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cp /etc/xpra/xorg.conf /etc/X11/xorg.conf.d/00_xpra.conf
RUN echo "xvfb=Xorg" >> /etc/xpra/xpra.conf

# Create a non-root user to run xpra
RUN adduser picarduser

# Create the /tmp/.X11-unix directory with the correct permissions, and owned by root, as required by X11
RUN mkdir -p /tmp/.X11-unix && chown root:root /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix

# Create the XDG_RUNTIME_DIR directory with the correct permissions, owned by picarduser
RUN mkdir -p /run/xpra && chown picarduser:picarduser /run/xpra && chmod 775 /run/xpra

COPY scripts/entrypoint.sh /home/picarduser/entrypoint.sh
RUN chmod +x /home/picarduser/entrypoint.sh

WORKDIR /home/picarduser
USER picarduser

EXPOSE 5005

ENV XPRA_DISPLAY=":100"

# Simple healthcheck to ensure xpra is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD wget --spider --quiet http://localhost:5005/ || exit 1

CMD ["/home/picarduser/entrypoint.sh"]

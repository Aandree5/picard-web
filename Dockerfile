FROM aandree5/gui-web-base:latest

USER root

RUN apt-get update && apt-get install -y \
    picard  \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER guiwebuser

# Check if Picard is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD pgrep -x picard || exit 1

CMD ["start", "picard"]

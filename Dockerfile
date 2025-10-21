FROM aandree5/gui-web-base:v1.3.1

LABEL org.opencontainers.image.authors="Aandree5" \
    org.opencontainers.image.license="Apache-2.0" \
    org.opencontainers.image.url="https://github.com/Aandree5/picard-web" \
    org.opencontainers.image.title="Picard Web" \
    org.opencontainers.image.description="Image to run MusicBrainz Picard in the browser"

ARG PW_UID=1000
ARG PW_GID=1000
ENV PW_UID=$PW_UID
ENV PW_GID=$PW_GID

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    picard  \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
# Check if Picard is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD pgrep -x picard || exit 1

CMD ["start", "picard"]

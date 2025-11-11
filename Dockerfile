# Copyright 2025 André Silva
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM aandree5/gui-web-base:v1.9.2 AS minimal

LABEL org.opencontainers.image.authors="Aandree5" \
    org.opencontainers.image.license="Apache-2.0" \
    org.opencontainers.image.url="https://github.com/Aandree5/picard-web" \
    org.opencontainers.image.title="Picard Web" \
    org.opencontainers.image.description="Image to run MusicBrainz Picard in the browser"

# Directories for upstream image to set the correct permissions
# `pw` for image required scripts and files
# `picard-web` for user to persist
ENV APP_DIRS="/pw /picard-web"

EXPOSE 5000
EXPOSE 5443

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    picard \
    pcmanfm \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /picard-web/MusicBrainz \
    mkdir -p $GWB_HOME/.config \
    # Link picard config files so that source of truth is /picard-web/MusicBrainz
    && ln -sfn /picard-web/MusicBrainz $GWB_HOME/.config/MusicBrainz \
    # When loading new configuration (from options > maintenance),
    # picard will take a backup of the current configuration and try
    # to save it to /home/gwb/Documents, create a link for persistence
    && mkdir /picard-web/backups \
    && ln -sfn /picard-web/backups $GWB_HOME/Documents

# Overriding entrypoint
COPY scripts/entrypoint.sh /pw/entrypoint.sh
RUN chmod +x /pw/entrypoint.sh

RUN configure-xpra --content-type class-instance:Picard=text

# Container healthcheck
COPY scripts/healthcheck.sh /pw/healthcheck.sh
RUN chmod +x /pw/healthcheck.sh

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD /pw/healthcheck.sh

ENTRYPOINT [ "/pw/entrypoint.sh" ]
CMD ["start-app", "--title", "Picard Web", "picard"]

FROM minimal AS full

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    rsgain  \
    git \
    zip

RUN mkdir -p /picard-web/MusicBrainz/Picard/plugins \
    # Install official plugin (https://github.com/metabrainz/picard-plugins)
    && git clone https://github.com/metabrainz/picard-plugins /tmp/picard-plugins \
    && (cd /tmp/picard-plugins/plugins && zip -r /picard-web/MusicBrainz/Picard/plugins/replaygain2.zip replaygain2) \
    && (cd /tmp/picard-plugins/plugins && zip -r /picard-web/MusicBrainz/Picard/plugins/acousticbrainz.zip acousticbrainz) \
    && rm -rf /tmp/picard-plugins \
    # Install lyrics plugin (https://github.com/izaz4141/picard-lrclib)
    && git clone https://github.com/izaz4141/picard-lrclib /tmp/lrclib \
    && mv /tmp/lrclib/lrcget.py /tmp/lrclib/__init__.py \
    && (cd /tmp && zip -r /picard-web/MusicBrainz/Picard/plugins/lrclib.zip lrclib -x "lrclib/.git" "lrclib/readme") \
    && rm -rf /tmp/lrclib \
    # Enable plugins
    && echo "[setting]\nenabled_plugins=lrclib, replaygain2, acousticbrainz" > "/picard-web/MusicBrainz/Picard.ini"

# Set permissions
RUN chown -R "$PUID:$PGID" /picard-web \
    # Backup initial config so to be restored in case a bind is created on picard-web folder,
    # as binding to a host dir will always take the host as the source and thus clear picard-web folder,
    # entrypoint can then restore if needed
    && mkdir /pw/initial \
    && cp -a /picard-web/. /pw/initial/

RUN apt-get remove -y \
    git \
    zip \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

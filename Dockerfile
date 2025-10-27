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

FROM aandree5/gui-web-base:v1.7.0 AS minimal

LABEL org.opencontainers.image.authors="Aandree5" \
    org.opencontainers.image.license="Apache-2.0" \
    org.opencontainers.image.url="https://github.com/Aandree5/picard-web" \
    org.opencontainers.image.title="Picard Web" \
    org.opencontainers.image.description="Image to run MusicBrainz Picard in the browser"

# Directories for upstream image to set the correct permissions
# `$GWB_HOME/.config/MusicBrainz` is here to make sure permissions are correct
# even if the UID and GID have not changed
ENV APP_DIRS="/pw $GWB_HOME/.config/MusicBrainz"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    picard  \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /pw \
    && mkdir -p $GWB_HOME/.config/MusicBrainz/Picard/plugins \
    && ln -s $GWB_HOME/.config/MusicBrainz/Picard/plugins /pw/plugins \
    && mkdir /pw/backups

# Container healthcheck
COPY scripts/healthcheck.sh /pw/healthcheck.sh
RUN chmod +x /pw/healthcheck.sh

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD /pw/healthcheck.sh

CMD ["start-app", "picard"]

FROM minimal AS full

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    rsgain  \
    git \
    zip

# Install ReplayGain2 plugin (https://github.com/metabrainz/picard-plugins)
RUN git clone https://github.com/metabrainz/picard-plugins /tmp/picard-plugins \
    && (cd /tmp/picard-plugins/plugins && zip -r /pw/plugins/replaygain2.zip replaygain2) \
    && rm -rf /tmp/picard-plugins

# Install lyrics plugin (https://github.com/izaz4141/picard-lrclib)
RUN git clone https://github.com/izaz4141/picard-lrclib /tmp/lrclib \
    && mv /tmp/lrclib/lrcget.py /tmp/lrclib/__init__.py \
    && (cd /tmp && zip -r /pw/plugins/lrclib.zip lrclib -x "lrclib/.git" "lrclib/readme") \
    && rm -rf /tmp/lrclib

RUN apt-get remove -y \
    git \
    zip \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

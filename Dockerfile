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

FROM aandree5/gui-web-base:v2.0.0 AS minimal

LABEL org.opencontainers.image.authors="Aandree5" \
    org.opencontainers.image.license="Apache-2.0" \
    org.opencontainers.image.url="https://github.com/Aandree5/picard-web" \
    org.opencontainers.image.title="Picard Web" \
    org.opencontainers.image.description="Image to run MusicBrainz Picard in the browser"

# Directories that must be writable by the runtime user.
ENV APP_DIRS="/picard-web"

EXPOSE 5000
EXPOSE 5443
# Picard browser integration
EXPOSE 8000

USER root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    picard \
    && apt-get install -y --no-install-recommends \
    xfe \
    adwaita-qt \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /picard-web \
    && mkdir -p /usr/share/picard-web/initial/MusicBrainz \
    && mkdir -p /usr/share/picard-web/initial/backups \
    && chmod a+rwx /picard-web \
    && chmod -R a+rX /usr/share/picard-web/initial

# Clean xfe application menu entries
RUN sed -i "s/^Name=.*/Name=File Manager/" /usr/share/applications/xfe.desktop \
    && sed -i "s/^Name=.*/Name=Image Viewer/" /usr/share/applications/xfi.desktop \
    && sed -i "/^Exec=/a NoDisplay=true" /usr/share/applications/xfw.desktop \
    && sed -i "/^Exec=/a NoDisplay=true" /usr/share/applications/xfp.desktop \
    && sed -i "/^Exec=/a NoDisplay=true" /usr/share/applications/xfa.desktop

# Picard startup runs after the inherited entrypoint prepares the runtime home.
COPY scripts/start-picard.sh /pw/start-picard.sh
RUN chmod +x /pw/start-picard.sh

RUN configure-xpra --content-type class-instance:Picard=text

# TEMP - Dark theme for picard. v3 will handle dark theme differently and this will be removed
ENV QT_STYLE_OVERRIDE=Adwaita-Dark

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD pgrep -x picard >/dev/null && /gwb/healthcheck.sh || exit 1

USER gwb

CMD ["/pw/start-picard.sh"]

FROM minimal AS full

USER root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    rsgain  \
    git \
    zip \
    fonts-noto-cjk \
    && fc-cache -f -v

RUN mkdir -p /usr/share/picard-web/initial/MusicBrainz/Picard/plugins \
    # Install official plugin (https://github.com/metabrainz/picard-plugins)
    && git clone https://github.com/metabrainz/picard-plugins /tmp/picard-plugins \
    && (cd /tmp/picard-plugins/plugins && zip -r /usr/share/picard-web/initial/MusicBrainz/Picard/plugins/replaygain2.zip replaygain2) \
    && (cd /tmp/picard-plugins/plugins && zip -r /usr/share/picard-web/initial/MusicBrainz/Picard/plugins/acousticbrainz.zip acousticbrainz) \
    && rm -rf /tmp/picard-plugins \
    # Install lyrics plugin (https://github.com/izaz4141/picard-lrclib)
    && git clone https://github.com/izaz4141/picard-lrclib /tmp/lrclib \
    && mv /tmp/lrclib/lrcget.py /tmp/lrclib/__init__.py \
    && (cd /tmp && zip -r /usr/share/picard-web/initial/MusicBrainz/Picard/plugins/lrclib.zip lrclib -x "lrclib/.git" "lrclib/readme") \
    && rm -rf /tmp/lrclib \
    # Enable plugins
    && echo "[setting]\nenabled_plugins=lrclib, replaygain2, acousticbrainz" > "/usr/share/picard-web/initial/MusicBrainz/Picard.ini" \
    && chmod -R a+rX /usr/share/picard-web/initial

RUN apt-get remove -y \
    git \
    zip \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER gwb

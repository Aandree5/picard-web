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

FROM aandree5/gui-web-base:v1.5.2

LABEL org.opencontainers.image.authors="Aandree5" \
    org.opencontainers.image.license="Apache-2.0" \
    org.opencontainers.image.url="https://github.com/Aandree5/picard-web" \
    org.opencontainers.image.title="Picard Web" \
    org.opencontainers.image.description="Image to run MusicBrainz Picard in the browser"

# Directories for upstream image to set the correct permissions
# `$GWB_HOME/.config/MusicBrainz` is here just so permissions are correct for first run,
# need it form symlink below, and it's created by root so needs permissions fixed for picard
ENV APP_DIRS="/pw"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    picard  \
    xterm \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /pw \
    && ln -s $GWB_HOME/.config/MusicBrainz/Picard/plugins /pw/plugins

# Check if Picard is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD pgrep -x picard || exit 1

CMD ["start-app", "xterm"]

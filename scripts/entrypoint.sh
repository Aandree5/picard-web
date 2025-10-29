#!/bin/sh
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


create_directory_if_missing(){
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        chown $PUID:$PGID "$1"
    fi
}

# Create folder for backups
create_directory_if_missing "/picard-web/backups"

# When loading new configuration (from options > maintenance),
# picard will take a backup of the current configuration and try
# to save it to /home/gwb/Documents, create a link to the backups
# folder created above
if [ ! -L "$GWB_HOME/Documents" ];then
    if [ -d "$GWB_HOME/Documents" ]; then
        rm -rf "$GWB_HOME/Documents"
    fi
    
    ln -s /picard-web/backups $GWB_HOME/Documents
fi

# Link picard folder for persistence
if [ ! -f /picard-web/MusicBrainz ]; then
    create_directory_if_missing "$GWB_HOME/.config/MusicBrainz"
    ln -s $GWB_HOME/.config/MusicBrainz /picard-web/MusicBrainz
fi

exec /gwb/entrypoint.sh "$@"

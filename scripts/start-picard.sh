#!/bin/sh
# Copyright 2025 Andre Silva
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

set -eu

for source_path in /usr/share/picard-web/initial/*; do
    [ -e "$source_path" ] || continue

    name=$(basename "$source_path")
    destination="/picard-web/$name"
    if [ ! -e "$destination" ]; then
        if [ -d "$source_path" ]; then
            mkdir -p "$destination"
            cp -R "$source_path/." "$destination/"
        else
            cp "$source_path" "$destination"
        fi
    fi
done

ln -sfn /picard-web/MusicBrainz "$XDG_CONFIG_HOME/MusicBrainz"
ln -sfn /picard-web/backups "$HOME/Documents"

exec start-app --title "Picard Web" picard

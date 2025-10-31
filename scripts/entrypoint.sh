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

for dir in /pw/initial/*/; do
    dir=$(basename "$dir")
    if [ ! -d "/picard-web/$dir" ]; then
        mkdir -p "/picard-web/$dir"
        cp -a "/pw/initial/$dir/." "/picard-web/$dir/"
        chown -R "$PUID:$PGID" "/picard-web/$dir"
    fi
done

exec /gwb/entrypoint.sh "$@"

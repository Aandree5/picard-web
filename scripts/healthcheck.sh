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

# 1. Check if Picard process is running
# 2. Check GWB health
# 3. Exit with status 1 if any of the checks fail

if ! pgrep -x picard >/dev/null; then
    echo "Picard is not running"
    exit 1
fi

if ! /gwb/healthcheck.sh; then
    echo "GUI Web Base healthcheck failed"
    exit 1
fi

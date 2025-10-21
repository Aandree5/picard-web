#!/bin/sh

set -eu

# Target PUID and PGID
PUID=${PUID:-${PW_UID:-1000}}
PGID=${PGID:-${PW_GID:-1000}}

# Current guiwebbase UID and GID
CURRENT_UID=$(id -u guiwebbase || echo -1)
CURRENT_GID=$(id -g guiwebbase || echo -1)

APP_DIRS="/home/guiwebbase $XDG_RUNTIME_DIR"

echo "Current UID:GID = ${CURRENT_UID:-<missing>}:${CURRENT_GID:-<missing>}"
echo "Target UID:GID = ${PUID}:${PGID}"

TARGET_USER="guiwebbase"
TARGET_GROUP="guiwebbase"

# Update permissions if PW_UID/PW_GID differ from PUID/PGID
if [ "$CURRENT_UID" != "$PUID" ] || [ "$CURRENT_GID" != "$PGID" ]; then
    # Ensure group exists for PGID (create if missing)
    if getent group "${PGID}" >/dev/null 2>&1; then
        TARGET_GROUP=$(getent group "${PGID}" | cut -d: -f1)
        echo "Using existing group ${TARGET_GROUP} (GID ${PGID})"
    else
        # If guiwebbase exists, modify it, otherwise create new user
        if [ "${CURRENT_GID}" -ge 0 ]; then
            echo "Modifying existing group guiwebbase to GID:${CURRENT_GID}"
            groupmod -g "${PGID}" "guiwebbase"
        else
            echo "Creating group ${TARGET_GROUP} with GID ${PGID}"
            groupadd -g "${PGID}" "${TARGET_GROUP}"
        fi
    fi
    
    # Ensure a user exists with the target PUID
    if getent passwd "${PUID}" >/dev/null 2>&1; then
        TARGET_USER=$(getent passwd "${PUID}" | cut -d: -f1)
        echo "Found existing user ${TARGET_USER} with UID ${PUID}"
    else
        # If guiwebbase exists, modify it, otherwise create new user
        if [ "${CURRENT_UID}" -ge 0 ]; then
            echo "Modifying existing user guiwebbase to UID:${PUID} GID:${PGID}"
            usermod -u "${PUID}" -g "${PGID}" "guiwebbase"
        else
            echo "Creating user guiwebbase with UID:${PUID} GID:${PGID}"
            useradd -m -u "${PUID}" -g "${PGID}" -d "/home/guiwebbase" -s /bin/sh guiwebbase
        fi
    fi
    
    # Fix ownership of directories
    for d in ${APP_DIRS}; do
        if [ -e "${d}" ]; then
            echo "Fixing ownership for ${d} -> ${PUID}:${PGID}"
            chown -R "${PUID}:${PGID}" "${d}" || echo "chown failed on ${d}"
        else
            echo "Creating ${d} owned by ${PUID}:${PGID}"
            mkdir -p "${d}"
            chown "${PUID}:${PGID}" "${d}"
            chmod 700 "${d}"
        fi
    done
else
    TARGET_USER=$(getent passwd "$PUID" | cut -d: -f1)
fi

echo "Executing as $TARGET_USER"
exec dumb-init -- gosu "${TARGET_USER}" "$@"
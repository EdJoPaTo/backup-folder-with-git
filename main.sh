#!/usr/bin/env bash

# Load bash loadable sleep which doesnt spawn a new process for sleep then. When it doesnt work just use the executable and ignore the error
enable -f /usr/lib/bash/sleep sleep 2>/dev/null

set -eux

INTERVAL_MINUTES=${INTERVAL_MINUTES:-"60 * 5"} # default to every 5 hours
DATAPATH=${DATAPATH:-}
BACKUPPATH=${BACKUPPATH:-}

git clone --depth=1 "$REPO" backuprepo/ || git -C backuprepo pull --ff-only
cd backuprepo

echo "Start backup loop"

while true; do
	rsync --verbose --checksum --delete-delay --archive --exclude=.git "/data/$DATAPATH" "/backuprepo/$BACKUPPATH"

	git add -A
	git commit -m "backup" || true

	git push

	sleep $((60 * INTERVAL_MINUTES))

	git pull --ff-only
done

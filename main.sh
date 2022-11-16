#!/usr/bin/env bash
set -eux

INTERVAL_MINUTES=${INTERVAL_MINUTES:-"60 * 5"} # default to every 5 hours
DATAPATH=${DATAPATH:-}
BACKUPPATH=${BACKUPPATH:-}

git clone --depth=1 "$REPO" backuprepo/ || true
cd backuprepo

echo "Start backup loop"

while true; do
	git pull --ff-only

	rsync --verbose --checksum --delete-delay --archive --exclude=.git "/data/$DATAPATH" "/backuprepo/$BACKUPPATH"

	git add -A
	git commit -m "backup" || true

	git push

	sleep $((60 * INTERVAL_MINUTES))
done

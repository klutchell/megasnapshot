#!/usr/bin/env bash

if [ -f /config/megafuse.conf ]; then
	echo "using external configuration file"
elif [[ $MEGAUSER ]] && [[ $MEGAPASS ]]; then
	echo "writing new configuration file"
	cat << EOF > /config/megafuse.conf
USERNAME = $MEGAUSER
PASSWORD = $MEGAPASS
MOUNTPOINT = /data
CACHEPATH = /cache
EOF
else
	echo "no credentials provided"; exit 1
fi

echo "starting megafuse..."
/opt/megafuse/MegaFuse -c /config/megafuse.conf &>/dev/null &

sleep 5

counter=0
while ! mountpoint -q "/data" && [ "${counter}" -lt 20 ]; do
	echo "waiting for mount to complete..."
	sleep 1
	let counter=counter+1
done

if mountpoint -q "/data"; then
	[ -d "/snapshots/alpha.0" ] || { echo "snapshot not found"; exit 1; }
	mkdir -p "/data/snapshots" 2>/dev/null || true
	pushd "/snapshots/alpha.0" >/dev/null
	echo "compressing snapshot..."
	tar -czf "/data/snapshots/$(hostname)_$(date -r "/snapshots/alpha.0" +%Y.%m.%d_%H.%M.%S).tar.gz" *
	popd >/dev/null
else
	echo "mount failed or not ready"; exit 1
fi

echo "uploading snapshot..."
ls -t "/data/snapshots/$(hostname)_"* | sed -e '1,3d' | xargs -d '\n' rm -v

#!/usr/bin/env bash

if [ -f /config/megafuse.conf ]; then
	echo "using external configuration file"
elif [[ $MEGAUSER ]] && [[ $MEGAPASS ]]; then
	echo "using default configuration fil with provided username and password"
	sed -e "s|_MEGAUSER_|$MEGAUSER|" -e "s|_MEGAPASS_|$MEGAPASS|" /root/megafuse.conf /config/megafuse.conf
else
	echo "no credentials provided"; exit 1
fi

echo "starting megafuse..."
/opt/megafuse/MegaFuse -c "/config/megafuse.conf" &>/config/megafuse.log &

counter=0
while ! grep -q 'user received or updated' /config/megafuse.log && [ "${counter}" -lt 60 ]
do
	sleep 1
	let counter=counter+1
done

if mountpoint -q "/data" && [ "${counter}" -lt 60 ]
then
	echo "megafuse is ready"
	mkdir "/data/snapshots" 2>/dev/null || true 
	[ -d "/snapshots/alpha.0" ] || { echo "snapshot not found"; exit 1; }
	pushd "/snapshots/alpha.0" >/dev/null
	echo "compressing snapshot..."
	tar -czf "/data/snapshots/$(hostname)_$(date -r "/snapshots/alpha.0" +%Y.%m.%d_%H.%M.%S).tar.gz" *
	popd >/dev/null
else
	echo "megafuse failed or not ready"; exit 1
fi

echo "uploading snapshot..."
ls -alt "/data/snapshots/$(hostname)_"*
# 'upload riuscito'

echo "deleting oldest snapshots..."
ls -t "/data/snapshots/$(hostname)_"* | sed -e '1,3d' | xargs -d '\n' rm -v

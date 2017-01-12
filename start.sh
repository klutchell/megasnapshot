#!/usr/bin/env bash

# check for existing config
if [ -f /config/megafuse.conf ]; then
	echo "using external configuration file"
elif [[ $MEGAUSER ]] && [[ $MEGAPASS ]]; then
	echo "using default configuration with provided username and password"
	sed -e "s|_MEGAUSER_|${MEGAPASS}|" -e "s|_MEGAPASS_|${MEGAPASS}|" /root/megafuse.conf > /config/megafuse.conf
else
	echo "no credentials provided"; exit 1
fi

# set snapshot location
snapshot="/snapshots/alpha.0"
[ -d "${snapshot}" ] || { echo "snapshot not found"; exit 1; }

# set destination path based on hostname and date
[ -n "${HOSTNAME}" ] || { echo "hostname cannot be blank"; exit 1; }
echo "hostname is ${HOSTNAME}"
dest="/data/snapshots/${HOSTNAME}"
tarball="$(date -r "${snapshot}" +%Y.%m.%d_%H.%M.%S).tar.gz"

# start megafuse in the background and output to log
echo "starting megafuse..."
/opt/megafuse/MegaFuse -c "/config/megafuse.conf" &>/config/megafuse.log &

# wait up to a minute for mount to complete
counter=0
while ! grep -q 'user received or updated' /config/megafuse.log && [ "${counter}" -lt 60 ]
do
	sleep 1
	let counter=counter+1
done

# proceed if the mount appears valid
if mountpoint -q "/data" && [ "${counter}" -lt 60 ]
then
	echo "megafuse is ready"
	mkdir "${dest}" 2>/dev/null || true 
	
	# check if already exists
	[ -f "${dest}/${tarball}" ] && { echo "snapshot already exists on remote"; exit 0; }
	
	# compress
	pushd "${snapshot}" >/dev/null
	echo "compressing snapshot..."
	tar -czf "${dest}/${tarball}" *
	popd >/dev/null
else
	echo "megafuse failed or not ready"; exit 1
fi

echo "uploading snapshot..."
# force sync
ls -lt "${dest}"/

echo "removing old snapshots..."
# delete oldest snapshot if more than 3 exist
ls -t "${dest}"/ | sed -e '1,3d' | xargs -d '\n' rm -v
# force sync
ls -lt "${dest}"/

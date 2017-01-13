#!/usr/bin/env bash

# check for existing config
if [ -f /config/.megarc ]; then
	echo "using external configuration file"
elif [[ $MEGAUSER ]] && [[ $MEGAPASS ]]; then
	echo "using default configuration with provided username and password"
	sed -e "s|_MEGAUSER_|${MEGAUSER}|" -e "s|_MEGAPASS_|${MEGAPASS}|" /root/.megarc > /config/.megarc
else
	echo "no credentials provided"; exit 1
fi

# set snapshot location
snapshot="/snapshots/alpha.0"
[ -d "${snapshot}" ] || { echo "snapshot not found"; exit 1; }

# set destination path based on hostname and date
[ -n "${HOSTNAME}" ] || { echo "hostname cannot be blank"; exit 1; }
echo "hostname is ${HOSTNAME}"
remote_path="/Root/snapshots/${HOSTNAME}"
tarball="$(date -r "${snapshot}" +%Y.%m.%d_%H.%M.%S).tar.gz"

# print megals version
echo "megatools version info:"
megals --version

echo "cleaning temporary dir..."
rm -rvf "/cache/"*

# create remote dir
echo "creating remote directory..."
megamkdir --config "/config/.megarc" "${remote_path}"

count_remote()
{
	# list remote snapshots
	echo "remote directory contents:"
	megals --config "/config/.megarc" -lhn --header "${remote_path}"
	
	# count remote snapshots
	remote_count="$(megals --config "/config/.megarc" -n "${remote_path}" | wc -l)"
	echo "remote snapshot count: $remote_count"
}

count_remote

# check if already exists
echo "checking if ${tarball} already exists..."
if [ -n "$(megals --config "/config/.megarc" -n "${remote_path}" | grep "${tarball}")" ]
then
	echo "${tarball} already exists on remote"; exit 0
fi

# compress to cache volume
pushd "${snapshot}" >/dev/null
echo "compressing ${snapshot} to ${tarball}..."
tar -czf "/cache/${tarball}" * || exit 1
popd >/dev/null

# upload snapshot
echo "uploading ${tarball}..."
megaput --config "/config/.megarc" --path "${remote_path}/${tarball}" "/cache/${tarball}"

count_remote

while [ "${remote_count}" -gt 3 ]
do
	# delete oldest snapshot
	oldest="$(megals --config "/config/.megarc" -n "${remote_path}" | head -n1)"
	echo "removing ${oldest}..."
	megarm --config "/config/.megarc" "${remote_path}/${oldest}"
	
	count_remote
done

echo "cleaning temporary dir..."
rm -rvf "/cache/"*

exit 0

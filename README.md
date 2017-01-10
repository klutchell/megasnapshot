# megasync #

## Description ##

* docker image to mount my MEGA.nz cloud drive and upload snapshots

## Building ##

```bash
git clone git@github.com:klutchell/docker-megasync.git ~/.docker/images/megasync
docker build -t megasync ~/.docker/images/megasync
```

## Usage ##

### docker ###
```bash
docker run \
    --rm
    --name=megasync \
    -v path/to/config:/config \
    -v path/to/snapshots/target:/snapshots \
    -v /etc/localtime:/etc/localtime:ro \
    -v /dev/rtc:/dev/rtc:ro \
    -e PGID=<gid> -e PUID=<uid>  \
    -e TZ=<timezone> \
    -e HOSTNAME=$HOSTNAME \
    -e MEGAUSER=<mega username> \
    -e MEGAPASS=<mega password> \
    megasync
```

### docker-compose ###
```bash
nano ~/.docker/megasync.yml
```
```yaml
version: '2'
services:
    megasync:
        build: ./images/megasync
        container_name: megasync
        hostname: ${HOSTNAME}
        privileged: true
        volumes:
            - ./volumes/megasync/config:/config
            - ./volumes/rsnapshot/target:/snapshots
            - /etc/localtime:/etc/localtime:ro
            - /dev/rtc:/dev/rtc:ro
```
```bash
HOSTNAME=$HOSTNAME docker-compose -f ~/.docker/megasync.yml build megasync
HOSTNAME=$HOSTNAME docker-compose -f ~/.docker/megasync.yml run --rm megasync
```

## Contributing ##

* n/a

## Author ##

* Kyle Harding <kylemharding@gmail.com>

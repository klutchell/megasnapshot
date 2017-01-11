# megasync #

## Description ##

* docker image to mount my MEGA.nz cloud drive and upload snapshots
* uses https://github.com/matteoserva/MegaFuse for mounting

## Usage ##

### docker ###
#### build ####
```bash
git clone git@github.com:klutchell/docker-megasync.git ~/.docker/images/megasync
docker build -t megasync ~/.docker/images/megasync
```
#### run ####
```bash
docker run \
    --rm
    --privileged
    --name=megasync \
    -v path/to/config:/config \
    -v path/to/snapshots/target:/snapshots \
    -e HOSTNAME=$HOSTNAME \
    -e MEGAUSER=<mega username> \
    -e MEGAPASS=<mega password> \
    megasync
```

### docker-compose ###
#### build ####
```bash
git clone git@github.com:klutchell/docker-megasync.git ~/.docker/images/megasync
HOSTNAME=$HOSTNAME docker-compose -f ~/.docker/images/megasync/megasync.yml build megasync
```
#### run ####
```bash
HOSTNAME=$HOSTNAME docker-compose -f ~/.docker/images/megasync/megasync.yml run --rm megasync
```

## Contributing ##

* n/a

## Author ##

* Kyle Harding <kylemharding@gmail.com>

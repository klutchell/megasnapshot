# megasync #

## Description ##

* docker image to upload existing snapshots to a MEGA.nz cloud drive
* uses https://github.com/megous/megatools

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
    --rm \
    --privileged \
    --name=megasync \
    -v path/to/config:/config \
    -v path/to/snapshots/target:/snapshots \
    -e HOSTNAME="$(hostname)" \
    -e MEGAUSER="your_username" \
    -e MEGAPASS="your_password" \
    megasync
```

### docker-compose ###
#### build ####
```bash
git clone git@github.com:klutchell/docker-megasync.git ~/.docker/images/megasync
docker-compose -f ~/.docker/images/megasync/megasync.yml build megasync
```
#### run ####
```bash
docker-compose -f ~/.docker/images/megasync/megasync.yml run \
    --rm \
    -e HOSTNAME="$(hostname)" \
    -e MEGAUSER="your_username" \
    -e MEGAPASS="your_password" \
    megasync
```

## Contributing ##

* n/a

## Author ##

* Kyle Harding <kylemharding@gmail.com>

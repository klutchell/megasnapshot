# megasnapshot #

## Description ##

This utility runs [rsnapshot](http://rsnapshot.org/) and megautils docker images to upload rsnapshot backups to a MEGA.nz cloud drive.

It pulls and runs the following docker images via [docker-compose](https://github.com/docker/compose):

Image | Size | Version
--- | --- | ---
[scandio/rsnapshot](https://hub.docker.com/r/scandio/rsnapshot/) | [![](https://images.microbadger.com/badges/image/scandio/rsnapshot.svg)](https://microbadger.com/images/scandio/rsnapshot=) | [![](https://images.microbadger.com/badges/version/scandio/rsnapshot.svg)](https://microbadger.com/images/scandio/rsnapshot)
[ubuntu:16.04](https://hub.docker.com/_/ubuntu/) | [![](https://images.microbadger.com/badges/image/ubuntu.svg)](https://microbadger.com/images/ubuntu) | [![](https://images.microbadger.com/badges/version/ubuntu.svg)](https://microbadger.com/images/ubuntu)

The megautils docker image is based on ubuntu and uses [megatools](https://github.com/megous/megatools) to upload to MEGA.nz.

## Installing ##

```bash
git clone git@github.com:klutchell/docker-megasnapshot.git ~/megasnapshot
sudo ~/megasnapshot/bin/install
~/megasnapshot/bin/configure
```

## Building ##

```bash
~/megasnapshot/bin/build
```

## Running ##

```bash
sudo ~/megasnapshot/bin/run rsnapshot alpha
sudo ~/megasnapshot/bin/run rsnapshot beta
sudo ~/megasnapshot/bin/run rsnapshot gamma
sudo ~/megasnapshot/bin/run rsnapshot delta
sudo ~/megasnapshot/bin/run megautils
```

## Scheduling ##

```bash
sudo ~/megasnapshot/bin/schedule
```

## Contributing ##

* n/a

## Author ##

* Kyle Harding <kylemharding@gmail.com>

## Credit ##

I give credit where it's due and would like to give a shoutout to the creators of the utilites/images used in this project:
* [megous](https://github.com/megous/)
* [scandio](https://bitbucket.org/scandio/)
* [rsnapshot](https://github.com/rsnapshot/)

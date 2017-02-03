# rsnapshot to mega #

## Description ##

This utility runs [rsnapshot](http://rsnapshot.org/) and megasync docker images to upload backups to a MEGA.nz cloud drive.
It pulls and runs the following docker images via [docker-compose](https://github.com/docker/compose):

Image | Size | Version
--- | --- | ---
[scandio/rsnapshot](https://hub.docker.com/r/scandio/rsnapshot/) | [![](https://images.microbadger.com/badges/image/scandio/rsnapshot.svg)](https://microbadger.com/images/scandio/rsnapshot=) | [![](https://images.microbadger.com/badges/version/scandio/rsnapshot.svg)](https://microbadger.com/images/scandio/rsnapshot)
[ubuntu:16.04](https://hub.docker.com/_/ubuntu/) | [![](https://images.microbadger.com/badges/image/ubuntu.svg)](https://microbadger.com/images/ubuntu) | [![](https://images.microbadger.com/badges/version/ubuntu.svg)](https://microbadger.com/images/ubuntu)

It also uses [megatools](https://github.com/megous/megatools) to upload to MEGA.nz.

## Installing ##

```bash
git clone git@github.com:klutchell/docker-megasync.git ~/megasync
sudo ~/megasync/bin/install
~/megasync/bin/configure
```

## Building ##

```bash
~/megasync/bin/build
```

## Running ##

```bash
sudo ~/megasync/bin/run rsnapshot alpha
sudo ~/megasync/bin/run rsnapshot beta
sudo ~/megasync/bin/run rsnapshot gamma
sudo ~/megasync/bin/run rsnapshot delta
sudo ~/megasync/bin/run megasync
```

## Scheduling ##

```bash
sudo ~/megasync/bin/schedule
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

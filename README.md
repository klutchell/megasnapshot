# megasnapshot #

## Description ##

Utilities to run [rsnapshot](http://rsnapshot.org/) and [megatools](https://github.com/megous/megatools/) docker images to create and upload backups to a mega.nz cloud drive.

It pulls and runs the following docker images:

Image | Size | Version
--- | --- | ---
[scandio/rsnapshot](https://hub.docker.com/r/scandio/rsnapshot/) | [![](https://images.microbadger.com/badges/image/scandio/rsnapshot.svg)](https://microbadger.com/images/scandio/rsnapshot) | [![](https://images.microbadger.com/badges/version/scandio/rsnapshot.svg)](https://microbadger.com/images/scandio/rsnapshot)
[klutchell/megatools](https://hub.docker.com/r/klutchell/megatools/) |[![](https://images.microbadger.com/badges/image/klutchell/megatools.svg)](https://microbadger.com/images/klutchell/megatools) | [![](https://images.microbadger.com/badges/version/klutchell/megatools.svg)](https://microbadger.com/images/klutchell/megatools)

## Installing ##

```bash
git clone git@github.com:klutchell/megasnapshot.git ~/megasnapshot
```

## Running ##

```bash
sudo ~/megasnapshot/bin/rsnapshot alpha
sudo ~/megasnapshot/bin/rsnapshot beta
sudo ~/megasnapshot/bin/rsnapshot gamma
sudo ~/megasnapshot/bin/rsnapshot delta
sudo ~/megasnapshot/bin/megaupload
```

## Scheduling ##

```bash
sudo ~/megasnapshot/bin/schedule
```

## Author ##

Kyle Harding <kylemharding@gmail.com>

## Credit ##

I give credit where it's due and would like to give a shoutout to the creators of the utilites/images used in this project:
* [megous](https://github.com/megous/)
* [scandio](https://bitbucket.org/scandio/)
* [rsnapshot](https://github.com/rsnapshot/)

[hub]: https://hub.docker.com/r/spritsail/beets
[git]: https://github.com/spritsail/beets
[drone]: https://drone.spritsail.io/spritsail/beets
[mbdg]: https://microbadger.com/images/spritsail/beets

# [spritsail/beets][hub]
[![Layers](https://images.microbadger.com/badges/image/spritsail/beets.svg)][mbdg]
[![Latest Version](https://images.microbadger.com/badges/version/spritsail/beets.svg)][hub]
[![Git Commit](https://images.microbadger.com/badges/commit/spritsail/beets.svg)][git]
[![Docker Stars](https://img.shields.io/docker/stars/spritsail/beets.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/spritsail/beets.svg)][hub]
[![Build Status](https://drone.spritsail.io/api/badges/spritsail/beets/status.svg)][drone]

A docker image for the music management program Beets. This image will start the beets web daemon in the container. You will also need to mount your music library inside the container, as well as any paths you wish to import music from.

Interacting with the beets database is simple, just use docker exec. For example, to get a full list of the library:
```
docker exec -ti beets beet ls
```

Or to import an album, assuming you are using the run command found below:
```
docker exec -ti beets beet import /import
```

# Example run command:
```
docker run -d --name beets --restart=on-failure:10 -v /host/path/to/config:/config -v /mnt/music:/music -v /mnt/imports:/import -p 8337:8337 spritsail/beets
```

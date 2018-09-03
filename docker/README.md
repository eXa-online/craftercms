# Docker build definitions

This folder contains auxiliary scripts and config files to build Docker images
for the CrafterCMS.

## Usage

0. cd into the top-level project folder

1. run `./gradlew init build deploy` in order to create the `crafter-authoring` and
   `crafter-delivery` folders

2. run `docker/prepare` which copies the Dockerfiles and required files into
   the appropriate environments
   
3. run `docker/build authoring` or `docker/build delivery` to create the
   cmsauthoring and cmsdelivery Docker images, respectively


## Start

Once the images are build, they are usable as a standalone container, with zero
configuration or setup needed:

```sh
docker run --rm -p 127.0.0.1:8080:8080 docker-harbor1.support.ecom.thalia.de/red/cmsauthoring
```

This exposes the studio at port 8080 on the local host only.

In production, you should bind mount a host folder or dedicated Docker volume to
the `/opt/data` directory in order to keep the dynamic data external:

```sh
docker run -d --name cmsauthoring -p 127.0.0.1:8080:8080 -v /opt/data/:/opt/data \
  docker-harbor1.support.ecom.thalia.de/red/cmsauthoring
```

_Note_: the services inside the container run as the `daemon` user, UID 1. Ensure that
        the user has write permissions in `/opt/data/`.

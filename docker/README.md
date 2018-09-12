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
docker run --rm -p 127.0.0.1:8080:8080 docker-harbor1.support.ecom.thalia.de/cms/cmsauthoring
```

This exposes the studio at port 8080 on the local host only.

In production, you should bind mount a host folder or dedicated Docker volume to
the `/opt/crafter/data` directory in order to store the dynamic data external:

```sh
docker run -d --name cmsauthoring -p 127.0.0.1:8080:8080 -v /opt/data/:/opt/crafter/data \
  docker-harbor1.support.ecom.thalia.de/cms/cmsauthoring
```

_Note_: the services inside the container run as the `daemon` user, UID 1. Ensure that
        the user has write permissions in `/opt/crafter/data/`.

## Publishing

The Docker images are published to the docker-harbor1.support.ecom.thalia.de Docker repository.

The `publish` stage of the Gitlab CI pipeline requires some variables to be set on the project level:

* `HARBOR_USER` - the user used to login to the Docker registry
* `HARBOR_PASSWORD` - the password of the user used to login to the Docker registry

## Deployment

The `deploy` stage of the Gitlab CI pipeline requires a few variables to be set:

* `SSH_KNOWN_HOSTS` - the SSH host keys of all target servers, obtained by running `ssh-keyscan` (see
  https://docs.gitlab.com/ee/ci/ssh_keys/#verifying-the-ssh-host-keys)

* `SSH_PRIVATE_KEY` - the private RSA key (see https://docs.gitlab.com/ee/ci/ssh_keys/#ssh-keys-when-using-the-docker-executor)

* `SSH_USER` - the user to use for the SSH connection (default: `root`)

The RSA public key must be copied to all servers for the configured `SSH_USER`.

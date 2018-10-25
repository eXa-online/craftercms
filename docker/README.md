# Docker build definitions

This folder contains auxiliary scripts and config files to build Docker images
for the CrafterCMS.

## Usage

0. cd into the top-level project folder

1. run `./gradlew init build deploy` in order to create the `crafter-authoring` and
   `crafter-delivery` folders

2. run `docker/prepare authoring` or `docker/prepare delivery` to copy the Dockerfiles and required files into
   the appropriate environment
   
3. run `docker/build authoring` or `docker/build delivery` to create the
   cmsauthoring and cmsdelivery Docker images, respectively


## Start

Once the images are build, they are usable as a standalone container, with zero
configuration or setup needed:

```sh
docker run --rm -p 8080:8080 -p 33306:33306 -p 8694:8694 docker-harbor1.support.ecom.thalia.de/cms/cmsauthoring
```

This exposes the ports 8080 (tomcat), 33306 (mariadb) and 8694 (solr) on the host machine.

In production, you should bind mount a host folder or dedicated Docker volume to
the `/opt/crafter/data` and `/opt/crafter/logs` directory in order to store the dynamic data externally:

```sh
docker run -d --name cmsauthoring -p 127.0.0.1:8080:8080 -v /opt/crafter/data/:/opt/crafter/data \
 -v /opt/crafter/logs/:/opt/crafter/logs \
  docker-harbor1.support.ecom.thalia.de/cms/cmsauthoring
```

_Note_: the services inside the container run as the `crafter` user. The Docker
        entrypoint script ensures that all files inside `/opt/crafter/data` are
        owned by this user at startup.

## Publishing

The Docker images are published to the docker-harbor1.support.ecom.thalia.de Docker repository.

The `publish` stage of the Gitlab CI pipeline requires some variables to be set on the project level:

* `HARBOR_USER` - the user used to login to the Docker registry
* `HARBOR_PASSWORD` - the password of the user used to login to the Docker registry

## Deployment

The `deploy` stage of the Gitlab CI pipeline pulls the required image from the docker-harbor1.support.ecom.thalia.de repository.
And starts the container. A few variables a required to be set:

* `SSH_KNOWN_HOSTS` - the SSH host keys of all target servers, obtained by running `ssh-keyscan` (see
  https://docs.gitlab.com/ee/ci/ssh_keys/#verifying-the-ssh-host-keys)

* `SSH_PRIVATE_KEY` - the private RSA key (see https://docs.gitlab.com/ee/ci/ssh_keys/#ssh-keys-when-using-the-docker-executor)

* `SSH_USER` - the user to use for the SSH connection (default: `root`)

_Note_: The `SSH_USER` needs sudo permissions since the deployment script must
        be run as root. Therefore, the root user should be able to pull docker
        images from docker-harbor1.support.ecom.thalia.de.

        Run `sudo docker login -u HARBOR_USER -p HARBOR_PASSWORD docker-harbor1.support.ecom.thalia.de`
        once on the target host.

### Add or update a target host

1) run `ssh-keyscan` for the host to obtain its host keys:

```sh
$ ssh-keyscan docker-cmsauthoring1.dev.ecom.thalia.de 2>/dev/null
docker-cmsauthoring1.dev.ecom.thalia.de ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGLe5rqhi1/fAJKcku9dglU3Tff3bJXMrdEVTnL+ZTNGZdBuELjlaXgN6z2MZtrEphUiQiuOI9GRjqvapC/mJ1X1cC2wOEaczYeb5bGtl62HUN2HAjDP1EvTWhrUv0v1SlnQ2EaUaIez/tBZGjNxN+0i88hivOnclJA9dFrxroIIP4iyquSE4YHj2R3Agy5PoM25zvRudTgcuqg40V/Zj2oKJ3aSn8xtM6m95Esv3gRI+CiajaK7Z3rKvUaqGD0SuaYmy+xRO7TYHx1SkwuyMt1BDUUwrSh5SPeSpFBrAT6cDDkoM3jR9MRZNX+O9OspaAeYNawrYRxeDx4i+Ylotd
docker-cmsauthoring1.dev.ecom.thalia.de ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIZUiI5x9lglBkBUqO1baHgvShB5ouY+pVJR9VZ68KOPPgqsrbq91QcLnQEr/uMu2l5+o9k42XC9UXllTCJcTRo=
docker-cmsauthoring1.dev.ecom.thalia.de ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPb4tq2j6Tkr1YRy5F6jLMoO8IgclgW89i7mSU7UAcYq
```

2) add or replace the keys for the host in the `SSH_KNOWN_HOSTS` variable in
   the CI/CD settings of this project

3) copy the RSA public key to the host for the `SSH_USER` you are using:

```sh
$ ssh-copy-id -i /home/gitlab-runner/.ssh/svc_harbor.pub USER@docker-cmsauthoring1.dev.ecom.thalia.de
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
claudio.bley@docker-cmsauthoring1.dev.ecom.thalia.de's password: 

Number of key(s) added: 1
```

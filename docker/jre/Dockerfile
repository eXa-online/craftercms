FROM openjdk:8-jre-slim

ENV CRAFTER_ROOT=/opt/crafter
ENV CRAFTER_HOME=/opt/crafter/bin

RUN apt-get update && apt-get install -y --no-install-recommends supervisor procps lsof \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/log/supervisor \
    && mkdir -p $CRAFTER_ROOT \
    && chown -R daemon: $CRAFTER_ROOT

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

# Local Variables:
# dockerfile-image-name: "docker-harbor1.support.ecom.thalia.de/cms/crafter-jre"
# End:

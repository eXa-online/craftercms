FROM openjdk:8-jre-slim

ENV CRAFTER_ROOT=/opt/crafter
ENV CRAFTER_HOME=/opt/crafter/bin
ENV CRAFTER_USER=crafter

COPY entrypoint.sh /

RUN apt-get update && apt-get install -y --no-install-recommends curl supervisor procps lsof \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/log/supervisor \
    && adduser --system --uid 144 --group --home $CRAFTER_ROOT $CRAFTER_USER

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

CMD [supervisord]

# Local Variables:
# dockerfile-image-name: "docker-harbor1.support.ecom.thalia.de/cms/crafter-jre:1"
# End:

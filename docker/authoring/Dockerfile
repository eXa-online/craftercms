
FROM docker-harbor1.support.ecom.thalia.de/red/crafter-jre

COPY --chown=daemon:daemon bin /opt/crafter/bin
COPY --chown=daemon:daemon data /opt/crafter/data
COPY --chown=root:root crafter-*.conf /etc/supervisor/conf.d/

EXPOSE 8080


# Local Variables:
# dockerfile-image-name: "docker-harbor1.support.ecom.thalia.de/red/crafter-authoring"
# End:

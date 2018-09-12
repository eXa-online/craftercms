
FROM docker-harbor1.support.ecom.thalia.de/cms/crafter-jre

COPY bin /opt/crafter/bin
COPY data /opt/crafter/data
COPY supervisor.conf /etc/supervisor/conf.d/crafter.conf

RUN chown daemon:daemon -R /opt/crafter/bin /opt/crafter/data \
    && chown root:root /etc/supervisor/conf.d/crafter.conf

EXPOSE 8080

# Local Variables:
# dockerfile-image-name: "docker-harbor1.support.ecom.thalia.de/cms/cmsauthoring"
# End:

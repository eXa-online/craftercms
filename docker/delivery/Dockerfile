
FROM docker-harbor1.support.ecom.thalia.de/cms/crafter-jre:1

COPY bin /opt/crafter/bin
COPY data /opt/crafter/data
COPY supervisor.conf /etc/supervisor/conf.d/crafter.conf

RUN chown $CRAFTER_USER: -R /opt/crafter/bin /opt/crafter/data \
    && chown root:root /etc/supervisor/conf.d/crafter.conf

EXPOSE 9080

# Local Variables:
# dockerfile-image-name: "docker-harbor1.support.ecom.thalia.de/cms/cmsdelivery"
# End:

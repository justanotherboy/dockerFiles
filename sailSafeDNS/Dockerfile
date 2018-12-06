ARG ALPINE_VERSION="3.8"

FROM alpine:$ALPINE_VERSION

MAINTAINER Mariano López

# Target FQDN to be resolved as part of the healthcheck
ENV TARGET_FQDN="example.com"

# Update repository and install unbound
RUN apk add --no-cache \
    drill \
    unbound

#################################
# UNBOUND CONFIGURATION CHANGES #
#################################

# Make a new folder to keep persistent files to make easier the use of volumes
RUN mkdir /etc/unbound/persistent  && \
    cp /usr/share/dnssec-root/trusted-key.key /etc/unbound/persistent/trusted-key.key && \
    chown unbound:unbound -R /etc/unbound/persistent && \
    chmod 644 /etc/unbound/persistent/trusted-key.key

# Change the trusted key file from trust-anchor to auto-trust-anchor to keep keys up to date
RUN echo $'\nserver:' >> /etc/unbound/unbound.conf && \
    sed -i 's/\/usr\/share\/dnssec-root\/trusted-key\.key//' /etc/unbound/unbound.conf && \
    echo $'\n\t# Update the trust anchor file' >> /etc/unbound/unbound.conf && \
    echo $'\tauto-trust-anchor-file: "/etc/unbound/persistent/trusted-key.key"' >> /etc/unbound/unbound.conf && \
# Listen on all container's interfaces
    echo $'\n\t# Listen on all interfaces' >> /etc/unbound/unbound.conf && \
    echo $'\tinterface: 0.0.0.0' >> /etc/unbound/unbound.conf && \
    echo $'\tinterface: ::0' >> /etc/unbound/unbound.conf && \
# Include the log options
    echo $'\n# Log options' >> /etc/unbound/unbound.conf && \
    echo $'include: /etc/unbound/log.conf' >> /etc/unbound/unbound.conf && \
# Include the allowed networks
    echo $'\n# Allowed networks' >> /etc/unbound/unbound.conf && \
    echo $'include: /etc/unbound/allow.conf' >> /etc/unbound/unbound.conf && \
# Include the resolvers
    echo $'\n# Default resolvers' >> /etc/unbound/unbound.conf && \
    echo $'include: /etc/unbound/resolvers.conf' >> /etc/unbound/unbound.conf

COPY allow.conf log.conf resolvers.conf /etc/unbound/

################################
# END OF CONFIGURATION CHANGES #
################################

COPY unbound_entry.sh /usr/sbin/unbound_entry.sh
RUN chmod 500 /usr/sbin/unbound_entry.sh

# Setting the check to use IPv4 because docker doesn't support IPv6 by default
HEALTHCHECK --interval=90s --timeout=5s --start-period=10s --retries=3 \
  CMD drill $TARGET_FQDN @127.0.0.1 || exit 1

# Expose the default DNS port
EXPOSE 53

# Run unbound-anchor and then unbound -h by default.
# It is possible to pass other arguments to unbound as parameters of "docker run"
ENTRYPOINT ["/usr/sbin/unbound_entry.sh"]
CMD ["-h"]

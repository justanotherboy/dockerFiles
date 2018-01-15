FROM alpine:latest

MAINTAINER Mariano López

# Update repository and install squid
RUN apk -U add squid

# Run squid with with --help by default
ENTRYPOINT ["/usr/sbin/squid"]

CMD ["-h"]

# Expose the default squid port
EXPOSE 3128

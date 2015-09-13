FROM rgibert/openjdk-8-jre
MAINTAINER Richard Gibert <richard@gibert.ca>
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        tomcat8 \
        && \
    unset DEBIAN_FRONTEND && \
    rm -r /var/lib/apt/lists/*

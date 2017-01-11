FROM ubuntu:16.04
MAINTAINER Kyle Harding <kylemharding@gmail.com>

RUN \
# Update and get dependencies
    apt-get update && apt-get install -y \
      libcrypto++-dev \
      libcurl4-openssl-dev \
      libdb++-dev \
      libfreeimage-dev \
      libreadline-dev \
      libfuse-dev \
      make \
      g++ \
      git \
      pkg-config \
      gettext \
    && \

# Fetch and make megafuse
    git clone https://github.com/matteoserva/MegaFuse /opt/megafuse && \
    cd /opt/megafuse && \
    make \
    && \

# Cleanup
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

COPY ./megafuse.conf /root/
COPY ./start.sh /root/

RUN chmod +x /root/start.sh

VOLUME /data /cache /config /snapshots

ENTRYPOINT ["/root/start.sh"]

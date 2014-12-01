FROM ubuntu:latest

RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy ca-certificates curl build-essential libsasl2-2 sasl2-bin libsasl2-2 libsasl2-dev libsasl2-modules --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENV LIBMEMCACHED_INSTALL /opt/libmemcached

RUN mkdir -p $LIBMEMCACHED_INSTALL
RUN curl -sSL https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz | tar -xvz -C $LIBMEMCACHED_INSTALL --strip-components 1
WORKDIR $LIBMEMCACHED_INSTALL
RUN ./configure --enable-sasl && \
    make && \
    make install
RUN ldconfig

ENTRYPOINT ["memstat"]

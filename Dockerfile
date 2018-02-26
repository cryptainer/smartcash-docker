FROM ubuntu:16.04

ARG smartcashVersion=1.1.1rc3-0xenial1
ARG _smartcashBin=/opt/smartcash/smartcashd
ARG _entryPointBin=/opt/docker-entrypoint.sh

ENV WALLET_CONF /etc/smartcash/smartcash.conf
ENV WALLET_DATA /data/

RUN apt-get update && \
    apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository ppa:smartcash/ppa && \
    apt-get update && \
    apt-get install -y smartcashd=$smartcashVersion && \
    apt-get purge -y python-software-properties

COPY /docker-entrypoint.sh $_entryPointBin

RUN mkdir -p `dirname $WALLET_CONF` && \
    mkdir -p `dirname $_smartcashBin` && \
    chmod +x $_entryPointBin && \
    ln -s $_entryPointBin /usr/local/bin/docker-entry

VOLUME /data


EXPOSE 9678 22350

ENTRYPOINT ["docker-entry"]


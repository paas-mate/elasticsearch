FROM ttbb/base

WORKDIR /opt/sh

ARG TARGETARCH

ARG amd_download=7.17.5-linux-x86_64

ARG arm_download=7.17.5-linux-aarch64

RUN if [[ "$TARGETARCH" = "amd64" ]]; \
    then download=$amd_download; \
    else download=$arm_download; \
    fi && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$download.tar.gz && \
    mkdir elasticsearch && \
    tar -xf elasticsearch-$download.tar.gz -C /opt/sh/elasticsearch --strip-components 1 && \
    rm -rf /opt/sh/elasticsearch-$download.tar.gz && \
    chown -R sh:sh /opt/sh/elasticsearch

ENV ELASTICSEARCH_HOME /opt/sh/elasticsearch

WORKDIR /opt/sh/elasticsearch

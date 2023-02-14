FROM shoothzj/base

RUN groupadd sh -g 1024 && \
    useradd -r -g sh sh -u 1024 -m -d /home/sh

WORKDIR /opt

ARG TARGETARCH
ARG amd_download=7.17.9-linux-x86_64
ARG arm_download=7.17.9-linux-aarch64

RUN if [ "$TARGETARCH" = "amd64" ]; \
    then download=$amd_download; \
    else download=$arm_download; \
    fi && \
    wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$download.tar.gz && \
    mkdir elasticsearch && \
    tar -xf elasticsearch-$download.tar.gz -C /opt/elasticsearch --strip-components 1 && \
    rm -rf /opt/elasticsearch-$download.tar.gz && \
    chown -R sh:sh /opt/elasticsearch

ENV ELASTICSEARCH_HOME /opt/elasticsearch

WORKDIR /opt/elasticsearch

USER sh

EXPOSE 9200 9300

ENTRYPOINT [ "/opt/elasticsearch/bin/elasticsearch", "-Ediscovery.type=single-node", "-Enetwork.host=0.0.0.0" ]

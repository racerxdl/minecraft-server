FROM ubuntu:focal

ENV GRAALVM_VERSION=20.2.0
ENV JAVA_HOME=/usr/lib/jvm/graalvm-ce-java11-${GRAALVM_VERSION}
ENV PATH=$JAVA_HOME/bin:$PATH

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN mkdir /usr/lib/jvm && \
    wget "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz" && \
    tar -zxC /usr/lib/jvm -f graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz && \
    rm -f graalvm-ce-java11-linux-amd64-${GRAALVM_VERSION}.tar.gz

RUN mkdir -p /opt/minecraft/data; \
  wget "https://ci.codemc.io/job/Spottedleaf/job/Tuinity/lastSuccessfulBuild/artifact/tuinity-paperclip.jar"; \
  mv tuinity-paperclip.jar /opt/minecraft

RUN wget https://github.com/itzg/rcon-cli/releases/download/1.4.8/rcon-cli_1.4.8_linux_amd64.tar.gz && \
    tar -xvC /opt/minecraft -f rcon-cli_1.4.8_linux_amd64.tar.gz && \
    rm rcon-cli_1.4.8_linux_amd64.tar.gz && \
    ln -s /opt/minecraft/rcon-cli /bin/rcon-cli

ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG TARGETVARIANT=""

EXPOSE 25565

VOLUME ["/opt/minecraft/data"]
WORKDIR /opt/minecraft/data

COPY server.sh /opt/

COPY server.properties.default /opt/minecraft

RUN chmod +x /opt/server.sh

CMD [ "/opt/server.sh" ]

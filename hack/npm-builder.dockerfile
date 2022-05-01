FROM node:lts as build
WORKDIR /app
RUN apt update && apt install entr -y && \
    apt -y autoremove && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENTRYPOINT ["/bin/bash", "-c"]
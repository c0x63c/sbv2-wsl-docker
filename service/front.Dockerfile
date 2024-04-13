FROM node:21.7.2-bookworm-slim

# system
RUN apt update -y -q && DEBIAN_FRONTEND=noninteractive apt install -y -q --no-install-recommends \
    curl git git-lfs vim \
    && rm -rf /var/lib/apt/lists/*

# git
RUN export GIT_SSL_NO_VERIFY=1 && git clone https://github.com/litagin02/Style-Bert-VITS2-Editor.git /sbv2-editor

# build
WORKDIR /sbv2-editor
RUN npm i && npm run build

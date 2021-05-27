FROM ubuntu:groovy

#zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev
RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    binutils \
    build-essential \
    curl \
    gettext \
    git \
    groff \
    jq \
    less \ 
    libffi-dev \
    libssl-dev \
    make \
    python3-dev \
    python3-pip \
    python3-venv \
    unzip \
    vim \
    wget \
    zip

# configure Python
RUN if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi
RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

## AWS
# install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# install AWS Session Manager Plugin
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
RUN dpkg -i session-manager-plugin.deb

# ## GOSS
# install goss
# See https://github.com/aelsabbahy/goss/releases for release versions
ENV GOSS_VERSION=v0.3.10
RUN curl -L "https://github.com/aelsabbahy/goss/releases/download/${GOSS_VERSION}/goss-linux-amd64" -o /usr/local/bin/goss
RUN chmod +rx /usr/local/bin/goss

# (optional) dgoss docker wrapper (use 'master' for latest version)
ENV DGOSS_VERSION=v0.3.10
RUN curl -L "https://github.com/aelsabbahy/goss/releases/download/${DGOSS_VERSION}/dgoss" -o /usr/local/bin/dgoss
RUN chmod +rx /usr/local/bin/dgoss

RUN mkdir -p /usr/local/goss-tests
COPY tests/goss-commands.yml /usr/local/goss-tests
COPY tests/goss-packages.yml /usr/local/goss-tests
COPY tests/goss.yaml /usr/local/goss-tests

WORKDIR /usr/src
CMD ["bash", "-l"]
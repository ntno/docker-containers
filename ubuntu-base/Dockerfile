FROM ubuntu:focal
ENV DEBIAN_FRONTEND=nonintercative
RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    binutils \
    build-essential \
    curl \
    git \
    jq \
    less \
    make \
    man \
    python3-dev \
    python3-doc \
    python3-pip \
    python3-venv \
    software-properties-common \
    unzip \
    vim  \
    wget \
    zip 

RUN apt-get update

# Python
RUN if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi
RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

# Goss
# See https://github.com/aelsabbahy/goss/releases for release versions
ENV GOSS_VERSION=v0.3.10
RUN curl -L "https://github.com/aelsabbahy/goss/releases/download/${GOSS_VERSION}/goss-linux-amd64" -o /usr/local/bin/goss
RUN chmod +rx /usr/local/bin/goss

# Buildenv
ENV BUILDENV_RELEASE=0.5.7
RUN cd /usr/local/bin && \
	wget -O /tmp/buildenv.tar.gz https://github.com/Comcast/Buildenv-Tool/releases/download/${BUILDENV_RELEASE}/buildenv-linux_amd64-${BUILDENV_RELEASE}.tar.gz && \
	tar xzvf /tmp/buildenv.tar.gz -C /tmp && \
	mv /tmp/buildenv /usr/local/bin/buildenv && \ 
	chown root:root /usr/local/bin/buildenv && \ 
	chmod 755 /usr/local/bin/buildenv && \
	rm -rf /tmp/buildenv*

# Customizations 
ENV CONFIG_DIR=/usr/local/ubuntu-base
RUN mkdir -p ${CONFIG_DIR}

# Configure .bash_profile
COPY .bash_profile /root/.bash_profile
COPY .bash_aliases /root/.bash_aliases

# Configure test directory
RUN mkdir -p ${CONFIG_DIR}/goss-tests
COPY tests/* ${CONFIG_DIR}/goss-tests

WORKDIR /usr/src
CMD ["/bin/bash", "-l"]
FROM ubuntu:groovy

RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    binutils \
    build-essential \
    curl \
    gettext \
    git \
    gnupg \
    groff \
    jq \
    less \ 
    libbz2-dev \
    libffi-dev \
    libncurses-dev \
    libreadline-dev \
    libssl-dev \
    libsqlite3-dev \
    make \
    python3-dev \
    python3-pip \
    python3-venv \
    screen \
    software-properties-common \
    unzip \
    vim \
    wget \
    zip \
    zlib1g-dev

# Hashicorp
# install terraform, packer, vault
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

ENV TERRAFORM_VERSION=0.14.5
ENV PACKER_VERSION=1.7.2
ENV VAULT_VERSION=1.7.2
RUN apt-get update && apt-get install \
    terraform=${TERRAFORM_VERSION} \
    packer=${PACKER_VERSION} \
    vault=${VAULT_VERSION}

# Python
RUN if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi
RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi
RUN pip install --no-cache --upgrade pip setuptools wheel virtualenv

# AWS
# install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# install AWS Session Manager Plugin
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
RUN dpkg -i session-manager-plugin.deb

# install AWS Elastic Beanstalk CLI
RUN cd /tmp && \
	git clone "https://github.com/aws/aws-elastic-beanstalk-cli-setup.git" && \
    python aws-elastic-beanstalk-cli-setup/scripts/ebcli_installer.py && \
    rm -rf /tmp/aws-elastic-beanstalk-cli-setup
RUN if [ ! -e /usr/bin/eb ]; then ln -sf /root/.ebcli-virtual-env/executables/eb /usr/bin/eb ; fi

# Node / NPM
RUN cd /tmp && \
    curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh && \ 
    bash nodesource_setup.sh && \
    rm -rf nodesource_setup.sh
RUN apt-get update && apt-get -y install nodejs

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

# Ansible / Molecule
ENV ANSIBLE_VENV_DIR=/usr/local/ansible-venv
RUN mkdir -p ${ANSIBLE_VENV_DIR}
COPY pip-requirements.txt ${ANSIBLE_VENV_DIR}/requirements.txt 
RUN cd ${ANSIBLE_VENV_DIR} && \
	virtualenv venv && \
	chmod +x ./venv/bin/activate && \
	./venv/bin/activate && \
	python3 -m pip install -r requirements.txt

# Configure SSH
RUN mkdir -p /root/.ssh
COPY ssh.config /root/.ssh/config
RUN chmod 600 /root/.ssh/config

# Configure .bash_profile
COPY .bash_profile /root/.bash_profile
COPY .bash_aliases /root/.bash_aliases

# Configure test directory
RUN mkdir -p /usr/local/goss-tests
COPY tests/* /usr/local/goss-tests

WORKDIR /usr/src
CMD ["bash", "-l"]
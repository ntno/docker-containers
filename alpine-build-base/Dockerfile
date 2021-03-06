FROM node:14.16.1-alpine3.12

ENV HOME /root

RUN apk update && apk add --no-cache \
	build-base \
	python3-dev \
	libffi-dev \
	openssl-dev \
	binutils \
	bash \
	make \
	wget \
	curl \
	unzip \
	zip \
	jq \
	git \
	gettext \
	python3 \
	py3-virtualenv \
	groff

# install glibc compatibility for alpine
# see https://github.com/aws/aws-cli/issues/4685#issuecomment-615872019
ENV GLIBC_VER=2.31-r0
RUN	curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub && \
	curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk && \
	curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk && \
	apk add --no-cache \
		glibc-${GLIBC_VER}.apk \
		glibc-bin-${GLIBC_VER}.apk

#set up python
ENV PYTHONUNBUFFERED=1
RUN if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi

RUN python3 -m ensurepip && \
	rm -r /usr/lib/python*/ensurepip && \
	pip3 install --no-cache --upgrade pip setuptools wheel

RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

#install terraform
ENV TERRAFORM_VERSION=0.14.5
RUN cd /usr/local/bin && \
	curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
	unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
	rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

#install buildenv
ENV BUILDENV_RELEASE=0.5.7
RUN cd /usr/local/bin && \
	wget -O /tmp/buildenv.tar.gz https://github.com/Comcast/Buildenv-Tool/releases/download/${BUILDENV_RELEASE}/buildenv-linux_amd64-${BUILDENV_RELEASE}.tar.gz && \
	tar xzvf /tmp/buildenv.tar.gz -C /tmp && \
	mv /tmp/buildenv /usr/local/bin/buildenv && \ 
	chown root:root /usr/local/bin/buildenv && \ 
	chmod 755 /usr/local/bin/buildenv && \
	rm -rf /tmp/buildenv*

#install awscli v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
	cd /tmp && \
	unzip awscliv2.zip && \
	./aws/install -i /usr/local/bin && \
	rm -rf /tmp/aws*

#install ebscli
RUN cd /tmp && \
	git clone "https://github.com/aws/aws-elastic-beanstalk-cli-setup.git" && \
	export CRYPTOGRAPHY_DONT_BUILD_RUST=1 && \
	python aws-elastic-beanstalk-cli-setup/scripts/ebcli_installer.py  --python-installation /usr/bin/python && \
	rm -rf /tmp/aws-elastic-beanstalk-cli-setup

#link /usr/bin/eb to the elastic beanstalk cli executale
RUN if [ ! -e /usr/bin/eb ]; then ln -sf /root/.ebcli-virtual-env/executables/eb /usr/bin/eb ; fi

#install packer
#https://github.com/hashicorp/docker-hub-images/blob/master/packer/Dockerfile-light
ENV PACKER_VERSION=1.7.2
ENV PACKER_SHA256SUM=9429c3a6f80b406dbddb9b30a4e468aeac59ab6ae4d09618c8d70c4f4188442e

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./

RUN sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS
RUN sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip

# install goss
# See https://github.com/aelsabbahy/goss/releases for release versions
ENV GOSS_VERSION=v0.3.10
RUN curl -L "https://github.com/aelsabbahy/goss/releases/download/${GOSS_VERSION}/goss-linux-amd64" -o /usr/local/bin/goss
RUN chmod +rx /usr/local/bin/goss

# customizations 
ENV CONFIG_DIR=/usr/local/alpine-build-base
RUN mkdir -p ${CONFIG_DIR}

# Configure .bash_profile
COPY .bash_profile /root/.bash_profile
COPY .bash_aliases /root/.bash_aliases

# Configure test directory
RUN mkdir -p ${CONFIG_DIR}/goss-tests
COPY tests/* ${CONFIG_DIR}/goss-tests

WORKDIR /usr/src
CMD ["bash", "-l"]
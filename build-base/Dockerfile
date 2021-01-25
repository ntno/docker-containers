FROM alpine:3.12.3

ENV HOME /root

RUN apk update && apk add --no-cache \
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
	groff

#set up python
ENV PYTHONUNBUFFERED=1
RUN if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi 

RUN python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel 
    

RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

#install awscli
RUN pip3 install awscli --upgrade --user
COPY .bash_profile $HOME/.bash_profile

#install terraform
ENV TERRAFORM_VERSION=0.14.5
RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

#install buildenv
ENV BUILDENV_RELEASE=0.5.3
ENV BUILDENV_VERSION=0.5.2
RUN cd /usr/local/bin && \
	wget -O /tmp/buildenv.tar.gz https://github.com/Comcast/Buildenv-Tool/releases/download/${BUILDENV_RELEASE}/buildenv-linux_amd64-${BUILDENV_VERSION}.tar.gz && \
	tar xzvf /tmp/buildenv.tar.gz -C /tmp && \
	mv /tmp/buildenv /usr/local/bin/buildenv && \ 
	chown root:root /usr/local/bin/buildenv && \ 
	chmod 755 /usr/local/bin/buildenv && \
	rm -rf /tmp/buildenv*

WORKDIR /usr/src

CMD ["bash", "-l"]
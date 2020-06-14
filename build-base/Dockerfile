FROM alpine:3.10.3

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
	python3 

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
ENV TERRAFORM_VERSION 0.12.26
RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip


WORKDIR /usr/src

CMD ["bash", "-l"]
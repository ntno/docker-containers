FROM alpine:3.10.3

ENV HOME /root

RUN apk update && apk add --no-cache \
	bash \
	make \
	wget \ 
	curl \ 
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

#set up awscli
RUN pip3 install awscli --upgrade --user
COPY .bash_profile $HOME/.bash_profile


WORKDIR /usr/src

CMD ["bash", "-l"]
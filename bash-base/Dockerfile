FROM alpine:3.12.3

RUN apk update && apk add --no-cache \
	bash \
	make \
	wget \ 
	curl \ 
	jq \ 
	git \
	gettext

ENV HOME /root
WORKDIR /usr/src

CMD ["bash", "-l"]
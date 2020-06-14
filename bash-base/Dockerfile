FROM alpine:3.10.3

RUN apk update && apk add --no-cache \
	bash \
	make \
	wget \ 
	curl \ 
	jq \ 
	git

ENV HOME /root
WORKDIR /usr/src

CMD ["bash", "-l"]
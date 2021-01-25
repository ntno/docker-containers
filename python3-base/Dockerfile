FROM ntno/bash-base:1.0.0

RUN apk update 

ENV PYTHONUNBUFFERED=1

RUN apk add --no-cache python3 

RUN if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi 

RUN python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel 
    

RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi


WORKDIR /usr/src

CMD ["bash", "-l"]

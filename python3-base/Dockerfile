FROM python:3.8.5

ENV PYTHONUNBUFFERED=1

RUN if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi 
RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

RUN python -m pip install --upgrade pip setuptools wheel build

WORKDIR /usr/src

CMD ["bash", "-l"]

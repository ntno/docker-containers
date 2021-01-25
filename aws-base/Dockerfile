FROM ntno/python3-base:1.0.0

RUN apk update
RUN pip3 install awscli --upgrade --user
COPY .bash_profile $HOME/.bash_profile

CMD ["bash", "-l"]

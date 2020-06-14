#!/bin/bash

docker build bash-base -t ntno/bash-base:latest
docker build python3-base -t ntno/python3-base:latest
docker build aws-base -t ntno/aws-base:latest
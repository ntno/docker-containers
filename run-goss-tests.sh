#!/bin/bash
cd /usr/local/goss-tests
goss render > goss-all.yml
goss -g goss-all.yml validate
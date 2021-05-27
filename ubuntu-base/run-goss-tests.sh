#!/bin/bash
cd /usr/local/goss-tests
echo "done cd"
goss render > goss-all.yml
echo "done render"
echo "cat in a hat" > idkman.txt
cat idkman.txt
cat goss-all.yml

#goss -g goss-all.yml validate
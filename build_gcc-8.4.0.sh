#!/bin/bash

docker run --rm -it -w /home \
       --name run_cpm_build -v $PWD:/home \
       cpm_gen:latest \
       ./src/install_gcc-8.4.0/install_gcc-8.4.0.sh


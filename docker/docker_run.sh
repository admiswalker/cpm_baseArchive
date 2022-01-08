#!/bin/sh
docker run --rm -it --name run_cpm -v $PWD:/home -w /home -p 8000:8000 cpm_gen:latest sh

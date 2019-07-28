#!/bin/bash
docker container rm workplace
docker run -it \
    --name workplace \
    -h workplace \
    --memory 64g \
    --memory-swap 64g \
    -v $1:/home/jupyter/work \
    --runtime=nvidia \
    mrx/analysis/gpu:0.1.0   


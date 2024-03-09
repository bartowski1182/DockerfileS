#!/bin/bash
source .env

docker build --build-arg branch=mixtral -t bartowski/mergekit .

#!/bin/bash
source .env

docker build --build-arg version="$EXLLAMAV2_VERSION" -t bartowski/exllamav2_inference .

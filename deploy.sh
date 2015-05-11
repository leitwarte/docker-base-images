#!/bin/bash

# Use the latest Leitwarte container

# Using the official Mongo channel
# https://registry.hub.docker.com/_/mongo/
docker run --name leitwarte-mongo -d mongo

docker run -d \
    -e ROOT_URL=http://leitwarte.local \
    -e MONGO_URL=mongodb://leitwarte-mongo:27017 \
    -p 80:3000 \
    --link leitwarte-mongo:mongo \
    --name leitwarte-web \
    leitwarte/leitwarte

#!/bin/bash

cd $HOME/cypherpost/compose/prod

CONFIG="$HOME/cypherpost/infra/nginx/nginx-conf"

cp $CONFIG/pre $CONFIG/default.conf && \
docker restart server

docker-compose up --no-deps certbot && \
cp $CONFIG/post $CONFIG/default.conf && \
docker restart server


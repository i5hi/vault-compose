#!/bin/bash

# copy config.json to mounted volume

# use correct domain name in nginx.conf

## NGINX CONFIG
REPO="$(dirname $(dirname $(pwd)))"
REPO_NGINX_CONF="$REPO/infra/nginx/prod/nginx-conf"

rm -rf "$REPO_NGINX_CONF/pre" "$REPO_NGINX_CONF/post"

cp "$REPO_NGINX_CONF/pre_template" "$REPO_NGINX_CONF/pre" 
perl -i -pe"s/___DOMAIN___/$MY_DOMAIN_NAME/g" "$REPO_NGINX_CONF/pre"

cp "$REPO_NGINX_CONF/post_template" "$REPO_NGINX_CONF/post" 
perl -i -pe"s/___DOMAIN___/$MY_DOMAIN_NAME/g" "$REPO_NGINX_CONF/post"

echo "[*] Created nginx pre & post conf files with $MY_DOMAIN_NAME as hostname."
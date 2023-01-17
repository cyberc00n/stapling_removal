#!/bin/bash
set -e
set -u

if ! [ -d /etc/nginx/sites-available/ ]; then
echo "Confings not found"
sleep 1
echo -n "Enter config directory:"
read -r config_directory
cp "$config_directory" /etc/nginx/"$config_directory".backup
sed -i "/^.*ssl_stapling/ d" "$config_directory"*
sed -i "/^.*ssl_trusted_certificate/ d" "$config_directory"*
sed -i "/^.*resolver/ d" "$config_directory"*
nginx -s reload && time nginx -t
echo "Done!"
else cp -R /etc/nginx/sites-available /etc/nginx/sites-available.backup
sed -i "/^.*ssl_stapling/ d" /etc/nginx/sites-available/*
sed -i "/^.*ssl_trusted_certificate/ d" /etc/nginx/sites-available/*
sed -i "/^.*resolver/ d" /etc/nginx/sites-available/*
nginx -s reload && time nginx -t
echo "Done!"
fi
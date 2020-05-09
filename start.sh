#!/bin/sh
docker build -t wireguard-socks-proxy .

docker run \
    -d -it \
    --name=vpn-client \
    --cap-add=NET_ADMIN \
    --publish 127.0.0.1:1080:1080 \
    --volume "$(realpath "$1"):/etc/wireguard/:ro" \
    --sysctl net.ipv6.conf.all.disable_ipv6=0 \
    --restart=unless-stopped \
    --privileged \
    wireguard-socks-proxy
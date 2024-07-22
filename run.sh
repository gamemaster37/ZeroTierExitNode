docker run -it --rm --cap-add NET_ADMIN --cap-add SYS_ADMIN --network host --device /dev/net/tun zt-exit-node:latest $NET_ID

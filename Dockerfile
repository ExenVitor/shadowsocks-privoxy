FROM alpine:latest
LABEL maintainer="exen3995@gmail.com"

#------------------------------------------------------------------------------
# Install packages:
#------------------------------------------------------------------------------

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN \
  apk --update --upgrade add \
      python3-dev \
      privoxy \
      git \
      libsodium \
  && rm /var/cache/apk/* \
  && pip3 install git+https://github.com/shadowsocks/shadowsocks.git@master \
  && apk del git

#------------------------------------------------------------------------------
# Environment variables:
#------------------------------------------------------------------------------

ENV SERVER_ADDR= \
    SERVER_PORT=8899  \
    METHOD=aes-256-cfb \
    TIMEOUT=300 \
    PASSWORD=

#------------------------------------------------------------------------------
# Populate root file system:
#------------------------------------------------------------------------------

ADD rootfs /

#------------------------------------------------------------------------------
# Expose ports and entrypoint:
#------------------------------------------------------------------------------
EXPOSE 8118 7070

ENTRYPOINT ["/entrypoint.sh"]

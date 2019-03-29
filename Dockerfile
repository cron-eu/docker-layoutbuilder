FROM node:6.11.0-alpine

ENV SASS_VERSION 2.2.0

# install fontcustom and sfnt2woff
RUN apk --update add curl make gcc libc-dev zlib-dev \
 && curl -o code.zip -Ls http://pkgs.fedoraproject.org/repo/pkgs/woff/woff-code-latest.zip/1dcdbc9a7f48086185740c185d822279/woff-code-latest.zip \
  && mkdir -p sfnt2woff \
  && unzip -d sfnt2woff code.zip && rm code.zip \
  && make -C sfnt2woff \
  && mv sfnt2woff/sfnt2woff /usr/local/bin/ \
  && rm -rf sfnt2woff \
  && apk add ruby-json ruby ruby-dev ruby-rdoc ruby-irb \
  && gem install fontcustom \
  && apk del ruby-dev \
  && apk del gcc libc-dev zlib-dev make \
  && rm /var/cache/apk/*

# install fontforge
# inspired by https://github.com/BWITS/Docker-builder/blob/master/fontforge/alpine/Dockerfile
RUN apk --update add libxml2-dev alpine-sdk xz poppler-dev pango-dev m4 libtool perl autoconf automake coreutils python-dev zlib-dev freetype-dev glib-dev cmake pango && \
    cd / && \
    git clone https://github.com/fontforge/libspiro.git && \
    cd libspiro && \
    autoreconf -i && \
    automake --foreign -Wall && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    git clone https://github.com/fontforge/libuninameslist.git && \
    cd libuninameslist && \
    autoreconf -i && \
    automake --foreign && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    git clone https://github.com/BWITS/fontforge.git && \
    cd fontforge && \
    ./bootstrap --force && \
    ./configure --without-iconv && \
    make && \
    make install && \
    apk del alpine-sdk xz poppler-dev pango-dev m4 libtool perl autoconf automake coreutils python-dev zlib-dev freetype-dev glib-dev cmake && \
    apk del libxml2-dev && \
    apk add libpng python freetype glib libintl libxml2 libltdl cairo && \
    rm /var/cache/apk/* && \
    rm -rf /fontforge /libspiro /libuninameslist

RUN apk --update add git make g++ \
  && cd / && git clone --recursive https://github.com/google/woff2.git \
  && cd /woff2 \
  && make all \
  && mv woff2_compress /usr/local/bin/ && mv woff2_decompress /usr/local/bin/ \
  && cd / && rm -rf /woff2 \
  && apk del git make g++ \
  && rm /var/cache/apk/*

# install git (needed for bower)
RUN apk --update add git \
  && npm install -g bower && npm install -g gulp  \
  && rm /var/cache/apk/*

# Install make and g++ temporary (to compile gulp-sass)
# Note: python is already installed
RUN apk --update add make g++ && rm /var/cache/apk/* \
  && npm config set python /usr/bin/python2.7 \
  && npm install gulp-sass@${SASS_VERSION} -g \
  && apk del g++ make

# Install make (needed for fontcustom)
RUN apk --update add make \
  && rm /var/cache/apk/*

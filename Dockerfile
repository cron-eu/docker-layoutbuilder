FROM node:6.11.0-alpine

RUN npm install -g bower && npm install -g gulp
RUN apk update && apk add python make g++
RUN npm config set python /usr/bin/python2.7
RUN npm install gulp-sass@2.2.0 -g

# install fontcustom and sfnt2woff
RUN apk add curl gcc libc-dev zlib-dev \
 && curl -o code.zip -Ls http://pkgs.fedoraproject.org/repo/pkgs/woff/woff-code-latest.zip/1dcdbc9a7f48086185740c185d822279/woff-code-latest.zip \
  && mkdir -p sfnt2woff \
  && unzip -d sfnt2woff code.zip && rm code.zip \
  && make -C sfnt2woff \
  && mv sfnt2woff/sfnt2woff /usr/local/bin/ \
  && rm -rf sfnt2woff \
  && apk add ruby-json ruby ruby-dev ruby-rdoc ruby-irb \
  && gem install fontcustom \
  && apk del ruby-dev \
  && apk del gcc libc-dev zlib-dev

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

RUN cd / && apk --update add git make g++ \
  && git clone --recursive https://github.com/google/woff2.git \
  && cd /woff2 \
  && make all \
  && mv woff2_compress /usr/local/bin/ && mv woff2_decompress /usr/local/bin/ \
  && cd / && rm -rf /woff2 \
  && apk del git g++ \
  && rm /var/cache/apk/*

# install git
RUN apk add --update git

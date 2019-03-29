FROM node:6-stretch

ENV SASS_VERSION 3.1.0

# install sfnt2woff, fontforge
RUN set -ex && apt-get update \
	&& apt-get install -y \
		woff-tools fontforge \
	&& rm -rf /var/lib/apt/lists/*

# Install bower gulp and gulp-sass in the desired version
RUN set -ex && npm install -g bower gulp gulp-sass@${SASS_VERSION}

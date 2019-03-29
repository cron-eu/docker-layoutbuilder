FROM node:6-stretch-slim

#ENV SASS_VERSION 3.1.0
ENV SASS_VERSION 2.2.0

# install sfnt2woff, fontforge
RUN set -ex && apt-get update \
	&& apt-get install -y \
		woff-tools fontforge \
	&& rm -rf /var/lib/apt/lists/*

# Install bower gulp and gulp-sass in the desired version
RUN set -ex \
	&& npm install -g bower gulp gulp-sass@${SASS_VERSION} \
	&& rm -rf /root/.npm

# Install fontcustom
RUN set -ex && apt-get update \
	&& apt-get install -y ruby ruby-dev build-essential \
	&& gem install fontcustom \
	&& apt-get --purge remove -y build-essential ruby-dev \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /root/.gem

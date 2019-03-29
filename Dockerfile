FROM node:6-stretch-slim

# install sfnt2woff, fontforge
RUN set -ex && apt-get update \
	&& apt-get install -y \
		woff-tools fontforge \
	&& rm -rf /var/lib/apt/lists/*

# Install fontcustom
RUN set -ex && apt-get update \
	&& apt-get install -y ruby ruby-dev build-essential \
	&& gem install fontcustom \
	&& apt-get --purge remove -y build-essential ruby-dev \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /root/.gem

# Build specific gulp-sass versions
# (keep this at the end of the Dockerfile, in order to reuse previous layers):
ARG SASS_VERSION

# Install bower gulp and gulp-sass in the desired version
RUN set -ex \
	&& npm install -g bower gulp gulp-sass@${SASS_VERSION} \
	&& rm -rf /root/.npm

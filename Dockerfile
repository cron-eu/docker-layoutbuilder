FROM node:6-stretch-slim

# install sfnt2woff, fontforge
RUN set -ex && apt-get update \
	&& apt-get install -y \
		woff-tools fontforge \
	&& rm -rf /var/lib/apt/lists/*

# Install fontcustom (and woff2 from source)
RUN set -ex && apt-get update \
	&& apt-get install -y ruby ruby-dev build-essential git \
	&& gem install fontcustom \
	&& cd / \
	&& git clone --recursive https://github.com/google/woff2.git \
	&& cd woff2 \
	&& make all \
	&& mv woff2_compress /usr/local/bin/ && mv woff2_decompress /usr/local/bin/ \
	&& cd / && rm -rf /woff2 \
	&& apt-get --purge remove -y build-essential ruby-dev git \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /root/.gem

# Install git and make (bower requires git)
RUN set -ex && apt-get update \
	&& apt-get install -y git make \
	&& rm -rf /var/lib/apt/lists/*

# Install bower gulp and gulp-sass in the desired version
RUN set -ex \
	&& npm install -g bower gulp \
	&& rm -rf /root/.npm

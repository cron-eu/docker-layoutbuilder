FROM node:6-stretch-slim

# install sfnt2woff, fontforge
RUN set -ex && apt-get update \
	&& apt-get install -y \
		woff-tools fontforge \
	&& rm -rf /var/lib/apt/lists/*

# Install fontcustom (and woff2 from source)
RUN set -ex && apt-get update \
	&& apt-get install -y ruby ruby-dev build-essential git \
	&& gem install fontcustom -v 1.3.8 \
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

# manually remove expired letsencrypt X3 certificate and install the new ISRG X1 root CA
RUN set -ex \
	&& mkdir -p /usr/share/ca-certificates/letsencrypt/ \
	&& cd /usr/share/ca-certificates/letsencrypt/ \
	&& curl -kLO https://letsencrypt.org/certs/isrgrootx1.pem \
	&& perl -i.bak -pe 's/^(mozilla\/DST_Root_CA_X3.crt)/!$1/g' /etc/ca-certificates.conf \
	&& update-ca-certificates

# Install git and make (bower requires git)
RUN set -ex && apt-get update \
	&& apt-get install -y git make \
	&& rm -rf /var/lib/apt/lists/*

# Install bower gulp and gulp-sass in the desired version
RUN set -ex \
	&& npm install -g bower gulp \
	&& rm -rf /root/.npm

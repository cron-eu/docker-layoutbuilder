layoutbuilder Docker Image
===

Docker Image based on `node:strech-slim` which includes NodeJS and some tools
needed to build layout artifacts for web projects:

* bower
* gulp
* git, make
* fontcustom
* sfnt2woff
* fontforge
* woff2

### Node version

Currently only node6 is supported (based on the node:6-stretch-slim official image)

### Available Tags

Currently there is a single Tag available: `node6-fontcustom`. This is subject
to change in future releases.

### Usage

```bash
docker run --rm --volumes-from davshopbase_web_1 \
  croneu/layoutbuilder:node6-fontcustom /bin/sh -c \
  "cd /data/www-provisioned/Packages/Sites/CRON.DavShop/Layout ; \
   mkdir -p node_modules ; \
   npm install ; bower install -s -f --allow-root ; gulp --neos"
```

### Development

See `Makefile` on how to build the images.

### Author

Remus Lazar

node-sass Docker Image
===

Docker Image based on `node:strech-slim` with node-sass support. Additionally this
image also includes:

* bower
* gulp
* git, make
* fontcustom
* sfnt2woff
* fontforge
* woff2

### Node version

Currently only node6 is supported (based on the node:6-stretch-slim official image)

### Usage

```bash
docker run --rm --volumes-from davshopbase_web_1 \
  remuslazar/docker-node-sass:node6 /bin/sh -c \
  "cd /data/www-provisioned/Packages/Sites/CRON.DavShop/Layout ; \
   mkdir -p node_modules ; \
   npm install ; bower install -s -f --allow-root ; gulp --neos"
```

### Development

See `Makefile` on how to build the images.

### Author

Remus Lazar

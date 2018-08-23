node-sass Docker Image
===

Docker Image based on `node:alpine` with node-sass support. Additionally this
image also includes:

* fontcustom
* sfnt2woff
* fontforge

### Usage

Use this image using `docker run`:

```bash
docker run --rm --volumes-from davshopbase_web_1 \
  remuslazar/docker-node-sass:latest /bin/sh -c \
  "cd /data/www-provisioned/Packages/Sites/CRON.DavShop/Layout ; \
   mkdir -p node_modules ; cp -a /usr/local/lib/node_modules/gulp-sass . ; \
   npm install ; bower install -s -f --allow-root ; gulp --neos"
```

### Author

Remus Lazar

node-sass Docker Image
===

Docker Image based on `node:alpine` with node-sass support. Additionally this
image also includes:

* fontcustom
* sfnt2woff
* fontforge

### Usage

This container comes with a globally installed gulp-sass package. To speedup
things you can use `npm link` to link the package to the local `node_modules`
folder prior to `npm install`.

Use this image using `docker run`:

```bash
docker run --rm --volumes-from davshopbase_web_1 \
  remuslazar/docker-node-sass:latest /bin/sh -c \
  "cd /data/www-provisioned/Packages/Sites/CRON.DavShop/Layout ; \
   mkdir -p node_modules ; \
   [ -d node_modules/gulp-sass ] || npm link gulp-sass ; \
   npm install ; bower install -s -f --allow-root ; gulp --neos"
```

### Known Limitations

You will not be able to compile `gulp-sass` because `g++` is missing. To do so,
install it manually prior to the `npm install` call:

```bash
apk --update add g++ make
```

A better approach is just using the globally installed version using `npm link`
(see above).

### Author

Remus Lazar

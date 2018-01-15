# Simple squid proxy

This is a simple proxy server using alpine container as base and running squid
with the default configuration. By default will display squid's help so it is
needed to specify the squid options you need along with "-N" to remain in
foreground.

## Commands

For the sake of the examples we will call the image generated 'proxy'

### Make your computer a cache proxy
```
docker run \
-p 3128:3128 \
proxy \
-N -d INFO
```
### Run squid in debug mode
```
docker run \
proxy \
-N -X
```

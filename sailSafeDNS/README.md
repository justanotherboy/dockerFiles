# DNS resolver

This docker image will crate a DNS resolver based on unbound for improved
privacy when resolving domain names.

This is a simple DNS server using alpine container as base and running unbound.
The entrypoint will update the DNS root keys and then run unbound (default will
display unbound's help) you need to pass the "-d" option to tell unbound to
remain in foreground.

## Configuration files

The idea to provide separated configuration files it is to make the image easy
to customize, here is a description of the provided configuration files:

- allow.conf: Allows recursive queries from localhost, RFC 1918 networks, and
IPv6 link-local networks.
- log.conf: Log to stderr
- resolvers.conf: Use [Cloudflare's open resolver](https://developers.cloudflare.com/1.1.1.1/setting-up-1.1.1.1/) using TLS

## Container's environment variables

- TARGET_FQDN: Fully Qualified Domain Name to resolve by the container for
health checks.
Default: example.com

## Example

For the sake of the examples the image name will be "dns"

### Make your computer a DNS resolver

docker run \\\
--net=host \\\
--dns=1.1.1.1 \\\
-e TARGET_FQDN="github.com" \\\
dns \\\
-d

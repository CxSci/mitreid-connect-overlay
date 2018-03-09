# Description

Use this Dockerfile to spin up a simple instance of [MITREid Connect OpenID Connect server](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server).

This is an overlay based in part on https://github.com/mitreid-connect/example-openid-connect-overlay and https://github.com/WISVCH/connect.

This Dockerfile is meant for development and is not a production-ready.

# Usage

```sh
docker build -t mit-cxsci-openid-connect .
docker run -ti -p 8080:8080 mit-cxsci-openid-connect
```

Override the default settings of the built image by copying the contents of `config` and mounting a volume of your own config files at `/etc/mitreid-connect`.

To persist data across runs, mount `/etc/hsqldb/data` as a volume.

By default, this server:

- Runs at http://localhost:8080/.
- Is HTTP only.
- Comes preloaded with two users: logins admin/password and user/password.
- Uses the same default keystore.jwks which is distributed with OpenID-Connect-Java-Spring-Server. Generate your own if you care about security.

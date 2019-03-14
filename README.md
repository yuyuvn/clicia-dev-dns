# clicia-dev-dns
DNS server for clicia.dev

## Build

```
docker build . -t clicia/clicia-dev-dns
```

## Run
```
docker run -p 53:53/udp --rm -it clicia/clicia-dev-dns
```

## Test
### Linux/MacOS
```
dig @localhost ns1.clicia.dev
```

### Windows
```
Resolve-DnsName -Name ns1.clicia.dev -Server 127.0.0.1
```

### Docker-compose
```
docker-compose run --rm test
docker-compose run --rm --entrypoint=/bin/sh test
```

## TODO
* Run test in github action
* Support DNSSEC
* Support TLS/gRPC

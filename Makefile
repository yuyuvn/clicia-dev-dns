build:
	docker build . -t clicia/clicia-dev-dns

test:
	docker build . -t clicia/clicia-dev-dns || exit 1
	docker run -p 53:53/udp -d --rm -it clicia/clicia-dev-dns || exit 1
	sleep 3
	dig @localhost ns1.clicia.net | grep "ANSWER SECTION" || exit 1

deploy:
	sudo cp -rf coredns/* /etc/coredns
	sudo service coredns reload

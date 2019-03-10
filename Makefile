build:
	docker build . -t clicia/clicia-dev-dns

# Run inside server
deploy:
	sudo cp -rf coredns/* /etc/coredns
	sudo service coredns reload

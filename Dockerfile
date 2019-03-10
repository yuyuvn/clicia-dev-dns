FROM coredns/coredns:1.4.0

COPY coredns /etc/coredns

EXPOSE 53 53/udp

ENTRYPOINT ["/coredns", "-conf=/etc/coredns/Corefile"]
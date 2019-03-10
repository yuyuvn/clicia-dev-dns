FROM sequenceiq/alpine-dig

WORKDIR /etc/coredns-test

RUN apk add --update make

COPY ./Makefile /etc/coredns-test

ENTRYPOINT ["make", "test"]
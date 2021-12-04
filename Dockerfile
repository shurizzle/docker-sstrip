FROM alpine:latest as build

RUN set -eux; \
    apk add build-base git; \
    git clone https://github.com/BR903/ELFkickers; \
    cd ELFkickers/sstrip; \
    sed -i 's/^CFLAGS.*$/& -static/g' Makefile; \
    make

FROM scratch

COPY --from=build /ELFkickers/sstrip/sstrip /sstrip

ENTRYPOINT ["/sstrip"]

CMD ["--help"]

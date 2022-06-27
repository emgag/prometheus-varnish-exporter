FROM golang:1.18 AS build
ARG VERSION
LABEL org.opencontainers.image.source = "https://github.com/emgag/prometheus-varnish-exporter"

RUN mkdir /build
WORKDIR /build

RUN git clone --depth 1 --branch ${VERSION} https://github.com/jonnenauha/prometheus_varnish_exporter \
    && cd prometheus_varnish_exporter \
    && CGO_ENABLED=0 go build -a -v

FROM scratch
COPY --from=build /build/prometheus_varnish_exporter/prometheus_varnish_exporter /prometheus_varnish_exporter
CMD ["/prometheus_varnish_exporter"]

FROM alpine:3.23@sha256:51183f2cfa6320055da30872f211093f9ff1d3cf06f39a0bdb212314c5dc7375 AS build

# renovate: datasource=github-releases depName=estesp/manifest-tool
ENV MANIFEST_VERSION=2.2.1

ARG TARGETARCH

RUN apk add --no-cache curl && \
    curl -sSLo- https://github.com/estesp/manifest-tool/releases/download/v${MANIFEST_VERSION}/binaries-manifest-tool-${MANIFEST_VERSION}.tar.gz | tar -xvzf - -C /tmp && \
    case "${TARGETARCH}" in \
    'amd64') \
        cp /tmp/manifest-tool-linux-amd64 /tmp/manifest-tool; \
        ;; \
    'arm64') \
        cp /tmp/manifest-tool-linux-arm64 /tmp/manifest-tool; \
        ;; \
    *) echo >&2 "error: unsupported architecture '${TARGETARCH}'"; exit 1 ;; \
    esac && \
    chmod 755 /tmp/manifest-tool

FROM alpine:3.23@sha256:51183f2cfa6320055da30872f211093f9ff1d3cf06f39a0bdb212314c5dc7375

RUN apk add --no-cache bash
ENTRYPOINT ["/usr/local/bin/entrypoint"]
COPY overlay /

COPY --from=build /tmp/manifest-tool /usr/bin/manifest-tool

FROM alpine:3.23@sha256:be171b562d67532ea8b3c9d1fc0904288818bb36fc8359f954a7b7f1f9130fb2 AS build

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

FROM alpine:3.23@sha256:be171b562d67532ea8b3c9d1fc0904288818bb36fc8359f954a7b7f1f9130fb2

RUN apk add --no-cache bash
ENTRYPOINT ["/usr/local/bin/entrypoint"]
COPY overlay /

COPY --from=build /tmp/manifest-tool /usr/bin/manifest-tool

FROM alpine:3.14 as build

# renovate: datasource=github-releases depName=estesp/manifest-tool
ENV MANIFEST_VERSION=1.0.3

ARG TARGETARCH

RUN apk add -U curl && \
    case "${TARGETARCH}" in \
    'amd64') \
        curl -sSLo /tmp/manifest-tool https://github.com/estesp/manifest-tool/releases/download/v${MANIFEST_VERSION}/manifest-tool-linux-amd64; \
        ;; \
    'arm64') \
        curl -sSLo /tmp/manifest-tool https://github.com/estesp/manifest-tool/releases/download/v${MANIFEST_VERSION}/manifest-tool-linux-arm64; \
        ;; \
    'arm') \
        curl -sSLo /tmp/manifest-tool https://github.com/estesp/manifest-tool/releases/download/v${MANIFEST_VERSION}/manifest-tool-linux-armv6; \
        ;; \
    *) echo >&2 "error: unsupported architecture '${TARGETARCH}'"; exit 1 ;; \
    esac && \
    chmod 755 /tmp/manifest-tool

FROM alpine:3.14

RUN apk add --no-cache bash
ENTRYPOINT ["/usr/local/bin/entrypoint"]
COPY overlay /

COPY --from=build /tmp/manifest-tool /usr/bin/manifest-tool

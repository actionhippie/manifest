FROM alpine:3.24@sha256:8ddefa941e689fc29abcdeb8dae3b3c6d139cc08ce9a52633931160701770685 AS build

# renovate: datasource=github-releases depName=estesp/manifest-tool
ENV MANIFEST_VERSION=2.2.2

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

FROM alpine:3.24@sha256:8ddefa941e689fc29abcdeb8dae3b3c6d139cc08ce9a52633931160701770685

RUN apk add --no-cache bash
ENTRYPOINT ["/usr/local/bin/entrypoint"]
COPY overlay /

COPY --from=build /tmp/manifest-tool /usr/bin/manifest-tool

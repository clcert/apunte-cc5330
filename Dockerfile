FROM debian:bookworm-slim

ARG HUGO_VERSION=0.158.0
ARG TARGETARCH

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git \
    && curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.tar.gz" -o /tmp/hugo.tar.gz \
    && tar -xzf /tmp/hugo.tar.gz -C /usr/local/bin hugo \
    && rm /tmp/hugo.tar.gz \
    && apt-get purge -y curl \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} hugo \
    && useradd -m -u ${UID} -g ${GID} hugo

USER hugo

WORKDIR /src

ENV HUGO_RESOURCEDIR=/home/hugo/.cache/hugo-resources

EXPOSE 1313

ENTRYPOINT ["hugo"]
CMD ["server", "--bind=0.0.0.0", "--noBuildLock", "--renderToMemory"]

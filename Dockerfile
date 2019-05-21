FROM alpine:latest

LABEL name="machsix/hugo:0.55.6"
LABEL maintainer="machsix <28209092+machsix@users.noreply.github.com>"
LABEL description="Hugo for docker"

ARG VERSION
ENV HUGO_VERSION ${VERSION:-0.55.6}

# Compile hugo
RUN apk add --no-cache wget git rsync go bash tar g++ libc-dev openssh && \
    wget https://github.com/gohugoio/hugo/archive/v${HUGO_VERSION}.tar.gz -O- | tar -xz && \
    cd hugo-${HUGO_VERSION} && \
    GOBIN=/usr/local/bin go install --tags extended && \
    strip /usr/local/bin/hugo && \
    apk del wget g++ go tar libc-utils && \
    apk add --no-cache libstdc++ && \
    rm -vrf /var/cache/apk/* && \
    cd ../ && rm -rf hugo-${HUGO_VERSION} && \
    rm -rf /root && mkdir /root

WORKDIR /root

VOLUME ["/root/.ssh"]

CMD ["/bin/bash"]

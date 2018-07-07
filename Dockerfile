FROM spritsail/alpine:3.8

ARG BEETS_VER=1.4.7
ARG CHROMAPRINT_VER=1.4.3

LABEL maintainer="Spritsail <beets@spritsail.io>" \
      org.label-schema.vendor="Spritsail" \
      org.label-schema.name="Beets" \
      org.label-schema.url="https://github.com/beetbox/beets" \
      org.label-schema.description="A music management and mp3 tagger, with streaming functionality" \
      org.label-schema.version=${BEETS_VER} \
      io.spritsail.version.beets=${BEETS_VER} \
      io.spritsail.version.chromaprint=${CHROMAPRINT_VER}

ENV BEETSDIR /config

ADD entrypoint /

RUN mkdir /config \
 && chmod +x /entrypoint \
 && apk add --no-cache py-pip openssl \
 && pip install flask beets discogs-client pyacoustid \
 && wget -O- https://github.com/acoustid/chromaprint/releases/download/v${CHROMAPRINT_VER}/chromaprint-fpcalc-${CHROMAPRINT_VER}-linux-x86_64.tar.gz \
      | tar xz -C /tmp --strip-components=1 \
 && mv /tmp/fpcalc /usr/bin \
 && rm -rf /tmp/*

EXPOSE 3887/tcp

VOLUME ["/config"]

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint"]

CMD ["beet", "web", "0.0.0.0"]

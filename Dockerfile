FROM alpine:3.6

MAINTAINER Adam Dodman <"adam.dodman@gmx.com">

ENV BEETSDIR /config

ADD entrypoint /

RUN mkdir /config \
 && chmod +x /entrypoint \
 && apk add --no-cache py-pip openssl tini\
 && pip install flask beets discogs-client pyacoustid \
 && wget -O- https://github.com/acoustid/chromaprint/releases/download/v1.4.2/chromaprint-fpcalc-1.4.2-linux-x86_64.tar.gz | tar xz \
 && mv chromaprint-fpcalc-1.4.2-linux-x86_64/fpcalc /usr/bin \
 && rm -rf /tmp/*

EXPOSE 3887/tcp

VOLUME ["/config"]

ENTRYPOINT ["tini", "--", "/entrypoint"]

CMD ["beet", "web", "0.0.0.0"]

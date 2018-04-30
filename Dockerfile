FROM alpine:3.6

WORKDIR /root/sentrix/
ADD run.sh dnsClient.py /root/sentrix/
RUN mkdir /root/data
VOLUME ["/root/data"]
ENV SERVERNAME=''
RUN apk --no-cache add \
    python \
    python-dev \
    py-pip \
    openssl-dev \
    py-virtualenv \
    gcc \
    libffi-dev \
    musl-dev \
    jpeg-dev \
    make \
    libressl \
    linux-headers \
    git \
    libevent-dev

RUN virtualenv -p python2.7 /synapse &&\
    source /synapse/bin/activate &&\
    pip install --upgrade pip &&\
    pip install --upgrade setuptools &&\
    pip install requests &&\
    pip install https://github.com/matrix-org/synapse/tarball/master

RUN git clone https://github.com/coturn/coturn.git /coturn &&\
    cd /coturn &&\
    ./configure &&\
    make &&\
    make install

RUN rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/* /root/.cache .wget-hsts


EXPOSE 8448/tcp 8008/tcp





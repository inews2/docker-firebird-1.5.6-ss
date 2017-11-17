FROM debian:stretch
MAINTAINER Mladen Petrovic <m.petrovic387@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Sarajevo

RUN dpkg --add-architecture i386 \
    && echo $TZ > /etc/timezone \
    && apt-get update \
    && apt-get install -y apt-utils procps curl libc6:i386 libncurses5:i386 libstdc++5:i386 vim nano tzdate \
    && rm /etc/localtime \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && curl -SL "http://downloads.sourceforge.net/project/firebird/firebird-linux-i386/1.5.6-Release/FirebirdSS-1.5.6.5026-0.nptl.i686.tar.gz" -o firebird.tar.gz \
    && mkdir -p /usr/src/firebird \
    && tar -xvf firebird.tar.gz -C /usr/src/firebird --strip-components=1 \
    && rm firebird.tar.gz \
    && cd /usr/src/firebird \
    && sed -i "141s/^/# /" install.sh \
    && sed -i "141s/^/# /" scripts/tarMainInstall.sh \
    && sed -i "237,238s/^/# /" scripts/postinstall.sh \
    && sed -i "238aNewPasswd=masterkey" scripts/postinstall.sh \
    && sh install.sh \
    && rm -rf /usr/src/firebird 

ENV PATH $PATH:/opt/firebird/bin

ADD librfunc.so /opt/firebird/UDF/librfunc.so
RUN chmod +x /opt/firebird/UDF/librfunc.so

VOLUME /data
VOLUME /backup

EXPOSE 3050/tcp

CMD ["/opt/firebird/bin/fbguard"]

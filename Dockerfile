FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y software-properties-common python-software-properties \
 && apt-get install -y apt-transport-https

RUN mkdir /tmp/rtvsfiles \
 && cd /tmp/rtvsfiles \
 && wget -O rtvs-daemon.tar.gz https://github.com/karthiknadig/docker-stuff/blob/master/rtvs-daemon_1.3.31011.1002.tar.gz?raw=true \
 && tar -xvzf rtvs-daemon.tar.gz \
 && /tmp/rtvsfiles/rtvs-install -s

RUN sh -c 'echo "deb https://cran.revolutionanalytics.com/bin/linux/ubuntu xenial/" > /etc/apt/sources.list.d/cran-r.list' \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean \
 && apt-get update --fix-missing \

RUN apt-get update && apt-get install -y r-base-dev
RUN apt upgrade -y

RUN useradd --create-home ruser1
RUN echo "ruser1:foobar" | chpasswd

EXPOSE 5444

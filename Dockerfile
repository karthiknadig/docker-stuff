FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y software-properties-common python-software-properties \
 && apt-get install -y apt-transport-https

RUN sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list' \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 \
 && sh -c 'echo "deb https://cran.revolutionanalytics.com/bin/linux/ubuntu xenial/" > /etc/apt/sources.list.d/cran-r.list' \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean \
 && apt-get update --fix-missing && apt-get update\
 && apt-get install -y dotnet-dev-1.0.4 r-base-dev libexplain51 libzip4 libc6 git

RUN apt upgrade -y

RUN mkdir /tmp/rtvsfiles && cd /tmp/rtvsfiles && git clone --recurse-submodules https://github.com/karthiknadig/docker-stuff.git && cd /

RUN cd /tmp/rtvsfiles 
RUN find -name *.deb | xargs dpkg -i
RUN apt-get -f install
RUN cp /tmp/rtvsfiles/docker-stuff/server.pfx /etc/rtvs
RUN rm -R /tmp/rtvsfiles

EXPOSE 5444
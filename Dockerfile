FROM debian:latest
MAINTAINER Alexis Pereda <alexis@pereda.fr>
LABEL description="Don't Starve Together Server"

RUN dpkg --add-architecture i386
RUN apt update && apt upgrade -y &&  apt install -y lib32gcc1 lib32stdc++6 libcurl4-gnutls-dev:i386 wget sudo

RUN useradd -ms /bin/bash steam
RUN mkdir /conf /mods && chown steam: /conf /mods

USER steam
WORKDIR /home/steam
RUN mkdir -p cmd apps/dst .klei

WORKDIR /home/steam/cmd
RUN wget -cO steamcmd_linux.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN tar zxf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz
RUN ./steamcmd.sh +login anonymous +force_install_dir /home/steam/apps/dst +app_update 343050 validate +quit

WORKDIR /home/steam
RUN ln -s /conf .klei/DoNotStarveTogether
RUN mv apps/dst/mods/* /mods && rmdir apps/dst/mods
RUN ln -s /mods apps/dst/mods

COPY launcher ./
COPY runner ./

USER root

ENTRYPOINT ["./launcher"]
CMD ["-nCluster_1"]

VOLUME ["/conf", "/mods"]
EXPOSE 10999/udp

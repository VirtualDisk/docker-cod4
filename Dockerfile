FROM docker.io/library/ubuntu:24.04 AS downloader
RUN apt update && apt install -y \
  unzip

WORKDIR /tmp
ADD https://cod4x.ovh/uploads/short-url/59kvOM9hBabZjPJRlLX029BcskI.zip /tmp/cod4.zip
RUN unzip cod4.zip \
  && mv cod4x_server-linux_21.2/cod4x-linux-server cod4x_server-linux_21.2/cod4

FROM docker.io/library/ubuntu:24.04

#from http://cod4-linux-server.webs.com/
RUN apt update && apt install -y \
  glibc-source \
  lib32stdc++6 \
  gcc-i686-linux-gnu \
  zlib1g-dev

RUN useradd cod4
COPY --from=downloader /tmp/cod4x_server-linux_21.2/cod4 /home/cod4
RUN chmod +x /home/cod4/cod4x18_dedrun \
  && chown -R cod4:cod4 /home/cod4

USER cod4
WORKDIR /home/cod4

ENTRYPOINT ["/home/cod4/cod4x18_dedrun"]

CMD ["+set sv_authorizemode '-1'", "+exec server.cfg", "+map_rotate"]

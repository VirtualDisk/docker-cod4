FROM docker.io/library/ubuntu:24.04

#from http://cod4-linux-server.webs.com/
RUN apt update
RUN apt install -y \
  glibc-source \
  lib32stdc++6 \
  gcc-i686-linux-gnu \
  zlib1g-dev

RUN useradd cod4
ADD cod4 /home/cod4/
RUN chown -R cod4:cod4 /home/cod4

USER cod4
WORKDIR /home/cod4

ENTRYPOINT ["/home/cod4/cod4x18_dedrun"]

CMD ["+set sv_authorizemode '-1'", "+exec server.cfg", "+map_rotate"]

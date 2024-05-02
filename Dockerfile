#docker run --security-opt seccomp=unconfined --security-opt apparmor=unconfined
from ubuntu:latest
RUN echo "nameserver 10.64.100.82" > /etc/resolv.conf
RUN echo "nameserver 10.64.100.103" >> /etc/resolv.confapt
RUN apt-get install -y curl
RUN apt-get install uidmap -y
RUN apt-get install -y iptables
RUN apt-get install -y kmod
RUN modprobe ip_tables

RUN useradd -ms /bin/bash newuser
RUN su user
RUN cd /home/user
RUN curl -fsSL https://get.docker.com/rootless | sh
RUN export XDG_RUNTIME_DIR=/home/user/.docker/run
RUN export PATH=/home/user/bin:$PATH
RUN export DOCKER_HOST=unix:///home/user/.docker/run/docker.sock
RUN dockerd-rootless.sh
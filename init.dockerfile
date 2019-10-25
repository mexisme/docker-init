# You should override $PARENT at build-time to name the upper-level container
#     e.g. node:7-alpine
# You may need to override $DOCKER_BASE if you're using this repo as a Submodule of another builder repo
# Override $CONFIG_FILE to use a different config. file

# Note: This will only work for recent versions of Docker
# Note: Your $PARENT base OS/Distribution (Debian or Alpine) must be compatible with the Golang builder base.
#      A Golang binary built with Debian won't usually work on Alpine out-of-the-box, for example

# Alpine-based:
ARG PARENT=alpine

# Debian-based:
#ARG PARENT=debian
#ARG PARENT=debian:9.9-slim

# Centos-based:
# ARG PARENT=centos

FROM $PARENT

# ENV lsb_release=stretch

# Set the locale(en_US.UTF-8)
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

USER root

COPY init/* tools/* /usr/local/bin/
RUN chmod 555 /usr/local/bin/*

RUN /usr/local/bin/initialise-docker-image
RUN /usr/local/bin/create-app-user

# Switch to using the "app" user by default at runtime
USER app
WORKDIR /app

ENV PATH=/app/bin:"$PATH"

#####
# Running a single process:

CMD /bin/sh


#####
# Running multiprocess with "runit" (http://smarden.org/runit/) :
#
# In your child image, you can run multi-process with "runit" by copying one of the below sections
# into your Dockerfile.
#
# NOTE: With "runit", you need to tell Docker to Term with SIGHUP instead:
#   https://github.com/peterbourgon/runsvinit
#   https://peter.bourgon.org/blog/2015/09/24/docker-runit-and-graceful-termination.html
#   https://github.com/pixers/runit-docker
#   https://docs.docker.com/engine/reference/builder/#stopsignal


#####
# Running multi-process with "runit", run as "root" user, with the various service scripts stored
# in /etc/services/
# NOTE: You'll need to use "chpst" (http://smarden.org/runit/chpst.8.html) inside your run scripts:

## (uncomment for multi-process, running "runit" as "root" user)
#STOPSIGNAL SIGHUP
#USER root
#COPY ${Your Runit Configs}/ /etc/service/
#CMD /usr/bin/runsvdir -P /etc/service


#####
# Running multi-process with "runit", run as "app" user, with the various service scripts stored
# in /app/services/

## (uncomment for multi-process, running "runit" as "app" user)
#STOPSIGNAL SIGHUP
#ENV SVDIR=/app/service
#RUN mkdir -p "$SVDIR"
#COPY ${Your Runit Configs}/ "$SVDIR/"
#CMD /usr/bin/runsvdir -P "$SVDIR"

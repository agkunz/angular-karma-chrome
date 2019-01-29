FROM ubuntu:latest

MAINTAINER Adam Kunz

# make sure repos are up to date
RUN apt-get update

# make sure we have some basic tools
RUN apt-get install -y curl git rsync

# add gitlab-runner repo
RUN curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | bash

# add nodejs repo
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# install the deps
RUN apt-get install -y \
  nodejs \
  gitlab-runner \
  chromium-browser;

# install angular
RUN npm install -g @angular/cli

# karma needs to know where chrome is at
ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/

# clean up whatever is left
RUN apt-get autoclean
RUN apt-get autoremove

# make sure we can have a shell when we drop
ENTRYPOINT /bin/bash
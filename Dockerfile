############################################################
# Dockerfile to run Leitwarte
# Based on Debian Jessie (8)
############################################################

FROM debian:jessie
MAINTAINER Stephan Hochhaus "stephan@yauh.de"

ENV BASE_DIR /opt
ENV SRC_DIR /opt/src
ENV APP_DIR /opt/app
ENV NODE_VERSION 0.10.36
ENV PORT 3000

# Prepare image
RUN apt-get update -y
RUN apt-get install -y curl python g++ make
RUN mkdir -p $SRC_DIR $APP_DIR

WORKDIR /opt

# Install Node.js
# optimize to only re-download node if it is not present
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& npm install -g npm \
	&& npm cache clear

WORKDIR /opt/src

# Get Leitwarte
RUN curl -SLO https://github.com/leitwarte/leitwarte/archive/master.tar.gz \
  && tar -xzf master.tar.gz -C "$SRC_DIR" --strip-components=1 \
  && rm master.tar.gz

# Build app
# Install Meteor
RUN curl https://install.meteor.com | /bin/sh
RUN npm install -g demeteorizer
RUN cd $SRC_DIR/app \
  && demeteorizer -o "$APP_DIR" \
  && cd $APP_DIR \
  && npm install

# Cleanup
# remove meteor at this point

# Run app
WORKDIR /opt/app
CMD node main

# Expose port
EXPOSE 3000

FROM ruby:2.5-alpine

LABEL maintainer="cherashev.f@gmail.com"

ARG rails_env=development

# Image building parameters
ENV APP_HOME="/var/www/cherashev" \
  APP_USER=ruby \
  PG_VERSION="10.3-r0" \
  PORT="4242"
ENV BUILD_PACKAGES="build-base" \
  DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev yaml-dev git nodejs" \
  RUNTIME_PACKAGES="yaml imagemagick cmake tzdata" \
  POSTGRES_PACKAGES="postgresql=$PG_VERSION postgresql-libs=$PG_VERSION postgresql-dev=$PG_VERSION postgresql-client=$PG_VERSION"

# System dependencies installation
RUN echo "@edge http://dl-3.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
	&& echo "@edgecommunity http://dl-3.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
	&& apk --update --no-cache add $BUILD_PACKAGES $RUNTIME_PACKAGES $DEV_PACKAGES $POSTGRES_PACKAGES \
	&& rm -rf /var/cache/apk/*

# Creating application home directory
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# Environment variables
ENV HOME=$APP_HOME \
	PATH=$APP_HOME/bin:$PATH \
	BUNDLE_GEMFILE=$APP_HOME/Gemfile \
	BUNDLE_PATH=/var/bundle \
	DOCKER="1" \
	RAILS_ENV=$rails_env

# Install gems
RUN mkdir -p $BUNDLE_PATH
ADD Gemfile* $APP_HOME/

# Add app's files
ADD . $APP_HOME

EXPOSE $PORT

CMD puma -C config/puma.rb

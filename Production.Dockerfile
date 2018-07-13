FROM ruby:2.5-alpine

LABEL maintainer="cherashev.f@gmail.com"

ARG rails_env=production

# Image building parameters
ENV APP_HOME="/var/www/cherashev" \
  APP_USER=ruby \
  PG_VERSION="10.4-r0" \
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

# Create a user for the app
RUN addgroup $APP_USER \
	&& adduser -D -G $APP_USER $APP_USER \
 	&& chown -R $APP_USER.$APP_USER $APP_HOME

# Environment variables
ENV HOME=$APP_HOME \
	PATH=$APP_HOME/bin:$PATH \
	BUNDLE_GEMFILE=$APP_HOME/Gemfile \
	BUNDLE_PATH=/var/bundle \
	DOCKER="1" \
	RAILS_ENV=$rails_env

# Install gems
RUN mkdir -p $BUNDLE_PATH
RUN chown -R $APP_USER:$APP_USER $BUNDLE_PATH
ADD --chown=ruby:ruby Gemfile* $APP_HOME/

# Change current user to ruby
USER ruby

# Install ruby gems
RUN bundle install --jobs 4 --retry 4 --clean --deployment --without development --without test --path=$BUNDLE_PATH

# Add app's files
ADD --chown=ruby:ruby . $APP_HOME

# Precompile assets
RUN bundle exec rails assets:precompile

EXPOSE $PORT

CMD puma -C config/puma.rb

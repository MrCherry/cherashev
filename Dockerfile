FROM ruby:2.4.2-alpine

LABEL maintainer="cherashev.f@gmail.com"

	# RUBY_VERSION="2.4.2-r0" \
	# BUNDLER_VERSION="1.15.4-r0" \
ENV APP_HOME="/var/www/cherashev" \
	PG_VERSION="9.6.5-r0" \
	PORT="4242" \
	DOCKER="1"

    # RUBY_PACKAGES="ruby@edge=$RUBY_VERSION ruby-io-console@edge=$RUBY_VERSION ruby-json@edge=$RUBY_VERSION ruby-bundler@edge=$BUNDLER_VERSION" \
# ENV BUILD_PACKAGES="curl-dev ruby-dev build-base readline-dev openssl-dev zlib-dev " \
ENV BUILD_PACKAGES="musl@edge=1.1.17-r2 build-base" \
	DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev yaml-dev git" \
	RUNTIME_PACKAGES="yaml imagemagick cmake tzdata" \
	POSTGRES_PACKAGES="postgresql=$PG_VERSION postgresql-libs=$PG_VERSION postgresql-dev=$PG_VERSION postgresql-client=$PG_VERSION"

 	# && apk --no-cache add $BUILD_PACKAGES $RUNTIME_PACKAGES $RUBY_PACKAGES $NODEJS_PACKAGES $DEV_PACKAGES $POSTGRES_PACKAGES \
	# && apk --no-cache add $BUILD_PACKAGES $RUNTIME_PACKAGES $DEV_PACKAGES $POSTGRES_PACKAGES \
RUN echo "@edge http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
	&& echo "@community http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
	&& apk --no-cache add git build-base postgresql-dev \
	&& rm -rf /var/cache/apk/*

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile
RUN bundle install --binstubs

ADD . $APP_HOME

# ADD bundler.sh $APP_HOME/

# RUN bundle config git.allow_insecure true \
# 	&& sh $APP_HOME/bundler.sh

# RUN bundle config git.allow_insecure true \
# 		&& bundle install --jobs 4 --retry 4 --deployment --without development --without test

# RUN RAILS_ENV=production bundle exec rake assets:precompile

# RUN apk del $BUILD_PACKAGES $DEV_PACKAGES $NODEJS_PACKAGES

EXPOSE $PORT

CMD puma -C config/puma.rb


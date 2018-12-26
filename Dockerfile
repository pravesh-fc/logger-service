FROM ruby:2.5.0-alpine

RUN apk update

RUN apk add --no-cache \
  build-base \
  libxml2-dev \
  libxslt-dev \
  mariadb-dev \
  tzdata -y \
  bash \
  nodejs

ENV RAILS_ENV production

ADD Gemfile /data/app/
ADD Gemfile.lock /data/app/

ENV APP_PATH /data/app/

WORKDIR $APP_PATH

RUN mkdir /data/app/log && \
  touch /data/app/log/cron_log.log && \
  touch /data/app/log/cron_error_log.log

RUN bundle install --binstubs --without development test

COPY . .

LABEL maintainer="Pravesh Khatri <pravesh.khatri@full-cycle.com>"

RUN RAILS_ENV=production bundle exec rake assets:precompile

RUN bundle exec whenever -c

RUN bundle exec whenever --set environment=development --update-crontab

CMD puma -C config/puma.rb
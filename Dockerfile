FROM ruby:2.3-alpine

RUN apk add --update \
  mysql-dev \
  build-base \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev

ADD . /usr/src/app
COPY entrypoint.sh /entrypoint.sh
RUN chmod 0777 /entrypoint.sh
WORKDIR /usr/src/app
RUN bundle config build.nokogiri --use-system-libraries && \
    bundle install

ENTRYPOINT ["/entrypoint.sh"]

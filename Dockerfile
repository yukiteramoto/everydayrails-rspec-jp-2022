FROM ruby:3.2.1
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

ENV APP_HOME /myapp
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install

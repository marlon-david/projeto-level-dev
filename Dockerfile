ARG RUBY_VERSION=3.2.0
FROM ruby:$RUBY_VERSION

# Dependências
RUN apt-get update -qq && apt-get install -y\
  apt-utils \
  build-essential \
  default-libmysqlclient-dev

# Usa uma configuração global mais moderna para o git default branch
RUN git config --global init.defaultBranch main

# Atualizando ruby dependency manager
RUN gem update --system
RUN gem install bundler

# Garantindo presença do Rails
ARG RAILS_VERSION=7.0.7.2
RUN gem install rails -v=$RAILS_VERSION

WORKDIR /usr/src/peeper
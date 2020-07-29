FROM ruby:2.7.1

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

    RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      nodejs build-essential libpq-dev git-all vim


ENV BUNDLE_PATH /gems
RUN mkdir $BUNDLE_PATH

COPY Gemfile .
RUN bundle install

ENV INSTALL_PATH /var/www/product_sales_api
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY . .

EXPOSE 3001

FROM ruby:2.5.0-alpine

# Ruby 2.5.0-alpine is based on an old Alpine release.
# Do NOT use Alpine Edge here — it gives us incompatible modern Node/npm
# packages for this legacy Rails application.

RUN apk add --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/v3.7/main \
    nodejs \
    nodejs-npm \
    libuv \
    shared-mime-info \
    sqlite \
    sqlite-dev \
    tzdata \
    build-base \
    libxml2-dev \
    libxslt-dev \
    bash \
    wget

# Legacy Rails 4.2 application -> Yarn 1
RUN npm install -g yarn@1.22.22

# Copy application
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Install Ruby dependencies
RUN bundle install

# Run Rails
CMD ["rails", "s", "-b", "0.0.0.0"]
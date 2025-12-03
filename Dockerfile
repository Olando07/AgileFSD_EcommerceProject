# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. 
# Use with Kamal or build'n'run by hand:
# docker build -t agile_fsd_ecommerce_project .

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.4.5
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages
# These are the runtime dependencies for the final image.
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips sqlite3 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems AND Node.js
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        build-essential git libpq-dev libyaml-dev pkg-config ca-certificates curl gnupg \
        dirmngr && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install Node.js and npm (Node 20)
# NOTE: Using a separate RUN step for clarity and better caching
RUN NODE_MAJOR=20 && \
    curl -fsSL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash - && \
    apt-get update -qq && \
    apt-get install -y nodejs && \
    apt-get remove -y dirmngr && \
    rm -rf /var/lib/apt/lists/*
    
# Install application gems
COPY Gemfile Gemfile.lock ./

# Final stage for app image
FROM base

# Copy built artifacts: gems, application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    mkdir -p db tmp log storage && \
    chown -R rails:rails db log storage tmp   
USER 1000:1000

# Entrypoint prepares the database.
COPY bin/docker-entrypoint /rails/bin/docker-entrypoint  
COPY bin /rails/bin   
COPY config /rails/config   
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start server via Thruster by default, this can be overwritten at runtime
EXPOSE 80
CMD ["./bin/thrust", "./bin/rails", "server"]
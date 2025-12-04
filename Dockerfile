# Dockerfile
FROM ruby:3.2.2

# Install Node 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install Yarn
RUN npm install -g yarn

# Install other dependencies
RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    build-essential \
    libpq-dev

# Set working directory
WORKDIR /app

# Copy Gemfile
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy package.json
COPY package.json yarn.lock ./
RUN yarn install

# Copy the app
COPY . .

# Precompile assets
RUN bundle exec rails assets:precompile

# Expose port
EXPOSE 3000

# Start server
CMD ["rails", "server", "-b", "0.0.0.0"]
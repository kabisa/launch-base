FROM ruby:2.5.1

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main"\
    > /etc/apt/sources.list.d/google-chrome.list
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -

# Install necessary libraries
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    postgresql \
    postgresql-contrib \
    google-chrome-stable \
    unzip \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN  wget --no-check-certificate https://chromedriver.storage.googleapis.com/2.35/chromedriver_linux64.zip \
  && unzip chromedriver_linux64.zip \
  && rm chromedriver_linux64.zip \
  && mv -f chromedriver /usr/local/share/ \
  && chmod +x /usr/local/share/chromedriver \
  && ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver \
  && chromedriver -v

# Setup peer trust for postgresql
RUN sed -i 's/md5\|peer/trust/' /etc/postgresql/*/main/pg_hba.conf

# Configure bundler
RUN gem install bundler
RUN bundle config --global path /cache/
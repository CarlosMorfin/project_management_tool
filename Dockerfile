FROM ruby:3.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /project_management_tool
COPY Gemfile /project_management_tool/Gemfile
COPY Gemfile.lock /project_management_tool/Gemfile.lock
RUN bundle install
COPY . /project_management_tool
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
      apt-utils \
      curl \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -y --no-install-recommends \
      nodejs \
    && npm install --global yarn && yarn install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

RUN groupadd -g 1000 app && \
    useradd -l -u 1000 -g app app && \
    install -d -m 0755 -o app -g app /home/app && \
    chown 1000:1000 -R /project_management_tool

USER 1000:1000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
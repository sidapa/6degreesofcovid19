FROM ruby:2.7.0

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs yarn mariadb-client
RUN mkdir /sixdegreesofcovid19
WORKDIR /sixdegreesofcovid19
COPY Gemfile /sixdegreesofcovid19/Gemfile
COPY Gemfile.lock /sixdegreesofcovid19/Gemfile.lock
RUN bundle install
COPY . /sixdegreesofcovid19

RUN bundle exec rake assets:precompile

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]


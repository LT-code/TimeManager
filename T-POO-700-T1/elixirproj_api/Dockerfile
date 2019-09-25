
# Elixir + Phoenix

FROM elixir:1.8.2-otp-22

RUN apt-get update && \
  apt-get install -y postgresql-client

RUN mkdir /back_app
WORKDIR /back_app
COPY . /back_app

ENV DB_HOST db

#RUN cd /gotcitytimemanager; \
RUN mix local.hex --force; \
    mix local.rebar rebar3 ./rebar3; \
    mix local.rebar --force; \
    mix deps.get --only prod

RUN mix compile

RUN apt-get update && apt-get install -y dos2unix

COPY ./entrypoint.sh /entrypoint.sh

RUN dos2unix /entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

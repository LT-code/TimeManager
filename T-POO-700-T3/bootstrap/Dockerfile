FROM elixir:1.8.2-otp-22

# updating
RUN apt-get update && \
  apt-get install -y postgresql-client

# add the project
COPY hello /home/project/
COPY entrypoint.sh /home/project/
WORKDIR /home/project/

# Install hex package manager
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix local.hex --force

# Compile the project
RUN mix do compile


#CMD ["/home/project/entrypoint.sh"]

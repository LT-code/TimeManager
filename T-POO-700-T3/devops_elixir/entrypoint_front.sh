#!/bin/bash
# Docker entrypoint script.


#while ! pg_isready -q -h db -p 5432 -U postgres
#do
#  echo "$(date) - waiting for database to start"
#  sleep 2
#done

## Create, migrate, and seed database if it doesn't exist.
#if [[ -z `psql -Atqc "\\list todo_list_dev"` ]]; then
#  echo "Database todo_list_dev does not exist. Creating..."
#  createdb -E UTF8 todo_list_dev -l en_US.UTF-8 -T template0
#  mix ecto.migrate
#  mix run priv/repo/seeds/clock_seeds.exs
#  mix run priv/repo/seeds/user_seeds.exs
#  mix run priv/repo/seeds/workingtime_seeds.exs
#  echo "Database todo_list_dev created."
#fi

exec npm run serve

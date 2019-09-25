#!/bin/bash

mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds/role.exs

exec mix phx.server

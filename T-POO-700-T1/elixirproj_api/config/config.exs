# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :todo_list,
  namespace: Todolist,
  ecto_repos: [Todolist.Repo]

# Configures the endpoint
config :todo_list, TodolistWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a6m1uwm7zkQnn8JISYSnKMgsZ71+mC7+OMCG/SQH5VJBc+upBdejOQJBB625Kn0j",
  render_errors: [view: TodolistWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Todolist.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :Todolist, Todolist.Guardian,
       issuer: "todo_list",
       secret_key: "eD4/QMs4iyKlKCeFaR2WtkmXolwMdigBP+rv2Oq69DvW8JJAE4GgZP2tSMsZ4vdR"

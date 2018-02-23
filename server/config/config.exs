# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :todo_app,
  ecto_repos: [TodoApp.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :todo_app, TodoAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V1LnQz0pDyJBl8qvhIQr7hg48ICiDGJxakzyM2zSNIhuexg4q8bxwSGmMlx59Ein",
  render_errors: [view: TodoAppWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: TodoApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

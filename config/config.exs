# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :division,
  ecto_repos: [Division.Repo]

# Configures the endpoint
config :division, DivisionWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/Cyk81T5hJ6w/fCZNzYu5ueLTD0MsgrBGlAVK97E1S3zU4uaAafrbtplE/TAic+y",
  render_errors: [view: DivisionWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Division.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

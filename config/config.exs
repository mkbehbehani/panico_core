# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :panico_core,
  ecto_repos: [PanicoCore.Repo]

# Configures the endpoint
config :panico_core, PanicoCore.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DpmRqPGOlKTg7vtFV5IIZVO9MNnAqsmHzDmc6ioQ/HfuoIugz0K8gb0ZqYHXDLH/",
  render_errors: [view: PanicoCore.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PanicoCore.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


  config :guardian, Guardian,
    allowed_algos: ["HS512"], # optional
      verify_module: Guardian.JWT,  # optional
        issuer: "MyApp",
          ttl: { 30, :days },
            allowed_drift: 2000,
              verify_issuer: true, # optional
                secret_key: "guardiansecretkey",
                  serializer: MyApp.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

use Mix.Config

config :subs, ecto_repos: [Subs.Repo]

import_config "#{Mix.env}.exs"

use Mix.Config

config :subs, ecto_repos: [Subs.Repo]

config :subs, :bcrypt, Comeonin.Bcrypt

import_config "#{Mix.env}.exs"

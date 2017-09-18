use Mix.Config

config :subs, ecto_repos: [Subs.Repo]

config :subs, :bcrypt, Comeonin.Bcrypt

config :subs, :subs_services, SubsServices

import_config "#{Mix.env}.exs"

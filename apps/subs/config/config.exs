use Mix.Config

config :subs, ecto_repos: [Repository.Repo]

config :subs, :bcrypt, Comeonin.Bcrypt

config :subs, :subs_services, SubsServices

config :subs, :dt, Subs.Helpers.DT

import_config "#{Mix.env}.exs"

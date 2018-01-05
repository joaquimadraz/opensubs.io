use Mix.Config

config :subs, ecto_repos: [Subs.Repo]

config :subs, :bcrypt, Comeonin.Bcrypt

config :subs, :subs_services, SubsServices

config :subs, :dt, Subs.Helpers.DT

config :subs, :deliver_notifications_at, 2 # 0 - 2

import_config "#{Mix.env}.exs"

use Mix.Config

config :notifier, ecto_repos: [Repository.Repo]

config :notifier, Notifier.Mailer,
  adapter: Bamboo.SMTPAdapter

config :notifier,
  :from_email, "john@snow.com"

import_config "#{Mix.env}.exs"

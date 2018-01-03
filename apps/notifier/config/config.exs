use Mix.Config

config :notifier, ecto_repos: [Notifier.Repo]

config :notifier, Notifier.Mailer,
  adapter: Bamboo.SMTPAdapter

import_config "#{Mix.env}.exs"

use Mix.Config

config :notifier, Notifier.Mailer,
  adapter: Bamboo.SMTPAdapter

import_config "#{Mix.env}.exs"

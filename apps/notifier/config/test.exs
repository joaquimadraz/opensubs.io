use Mix.Config

config :notifier, Notifier.Mailer,
  adapter: Bamboo.TestAdapter

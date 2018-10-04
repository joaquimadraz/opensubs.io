use Mix.Config

config :notifier, Notifier.Mailer,
  adapter: Bamboo.LocalAdapter

config :notifier, Notifier.Scheduler,
  jobs: [
    # Every minute
    {"* * * * *", {Notifier, :deliver_notifications, []}},
  ]

use Mix.Config

config :notifier, Notifier.Mailer,
  server: "localhost",
  port: 1025

config :notifier, Notifier.Scheduler,
  jobs: [
    # Every minute
    {"* * * * *", {Notifier, :deliver_notifications, []}},
  ]

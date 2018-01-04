use Mix.Config

# Configure your database
config :notifier, Notifier.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "subs_dev",
  hostname: "localhost",
  pool_size: 10

config :notifier, Notifier.Mailer,
  server: "localhost",
  port: 1025

config :notifier, Notifier.Scheduler,
  jobs: [
    # Every minute
    {"* * * * *", {Notifier, :deliver_notifications, []}},
  ]

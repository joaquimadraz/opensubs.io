use Mix.Config

# Configure your database
config :notifier, Notifier.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "subs_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :notifier, Notifier.Mailer,
  adapter: Bamboo.TestAdapter

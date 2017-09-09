use Mix.Config

# Configure your database
config :subs, Subs.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "subs_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

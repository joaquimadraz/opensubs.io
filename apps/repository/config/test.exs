use Mix.Config

# Configure your database
config :repository, Repository.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "subs_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

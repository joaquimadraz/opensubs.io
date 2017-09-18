use Mix.Config

# Configure your database
config :subs, Subs.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "subs_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :subs, :bcrypt, Subs.Test.Support.BCrypt

config :subs, :subs_services, Subs.Test.Support.SubsServicesMock

use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :subs_web, SubsWeb.Endpoint,
  http: [port: 4001],
  server: false

config :subs_web, :subs_services, Subs.Test.Support.SubsServicesMock

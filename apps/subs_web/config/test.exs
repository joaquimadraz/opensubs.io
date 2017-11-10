use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :subs_web, SubsWeb.Endpoint,
  http: [port: 4000],
  server: false

config :subs_web, :subs_services, Subs.Test.Support.SubsServicesMock

config :wallaby, phantomjs: "frontend/node_modules/phantomjs-prebuilt/bin/phantomjs"
config :wallaby, driver: Wallaby.Experimental.Chrome
config :wallaby, chrome: [headless: false]

use Mix.Config

config :subs, Subs.Scheduler,
  jobs: [
    # Every midnight
    {"@daily", {Subs.Application.DailyNotificationsBuilder, :build, []}},
  ]

import_config "prod.secret.exs"

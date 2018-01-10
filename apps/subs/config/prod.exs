use Mix.Config

config :notifier, Notifier.Scheduler,
  jobs: [
    # Every midnight
    {"@daily", {Subs.Application.DailyNotificationsBuilder, :build, []}},
  ]

import_config "prod.secret.exs"

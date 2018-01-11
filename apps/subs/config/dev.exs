use Mix.Config

config :subs, Subs.Scheduler,
  jobs: [
    # Every minute
    {"* * * * *", {Subs.Application.DailyNotificationsBuilder, :build, []}},
  ]

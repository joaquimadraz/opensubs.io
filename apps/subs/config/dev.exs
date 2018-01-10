use Mix.Config

config :notifier, Notifier.Scheduler,
  jobs: [
    # Every minute
    {"* * * * *", {Subs.Application.DailyNotificationsBuilder, :build, []}},
  ]

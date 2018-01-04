use Mix.Config

config :notifier, Notifier.Scheduler,
  jobs: [
    # Every day at 1am
    {"0 0 1 * *", {Notifier, :deliver_notifications, []}},
  ]

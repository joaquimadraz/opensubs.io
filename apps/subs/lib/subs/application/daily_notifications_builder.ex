defmodule Subs.Application.DailyNotificationsBuilder do
  alias Subs.{SubscriptionRepo, SubsNotificationRepo}

  @dt Application.get_env(:subs, :dt)

  def build(dt \\ @dt) do
    now = dt.now()
    from = dt.beginning_of_day(now)
    to = dt.end_of_day(now)

    SubscriptionRepo.get_billable_subscriptions(from, to)
    |> Enum.map(fn (subscription) ->
      case SubsNotificationRepo.create_from_subscription(subscription) do
        {:ok, subs_notification} -> subs_notification
      end
    end)
  end
end

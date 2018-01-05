defmodule Subs.Application.DailyNotificationsBuilder do
  alias Subs.{SubscriptionRepo, SubsNotificationRepo}
  alias Subs.Domain.NotificationTemplate

  @dt Application.get_env(:subs, :dt)

  def build(dt \\ @dt) do
    now = dt.now()
    from = dt.beginning_of_day(now)
    to = dt.end_of_day(now)

    # TODO: Refactor. Try grouping from the DB.
    SubscriptionRepo.get_billable_subscriptions(from, to)
    |> Enum.group_by(fn subscription -> subscription.user end)
    |> Enum.map(fn {user, subscriptions} ->
      template = NotificationTemplate.create_daily_notification(user, subscriptions)

      case SubsNotificationRepo.create(user, subscriptions, template, dt) do
        {:ok, subs_notification} -> subs_notification
      end
    end)
  end
end

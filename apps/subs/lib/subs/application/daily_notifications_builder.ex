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
    |> Enum.reduce(%{}, fn (subscription, acc) ->
      # next_bill_date calculation is outside notification create because we maybe not
      # want to send a notification for a particular subscription
      # TODO: Dunno. But I don't like this module.
      step = if(subscription.cycle == "monthly", do: :months, else: :years)

      next_bill_date = @dt.step_date(subscription.next_bill_date, step, 1)

      {:ok, subscription} =
        SubscriptionRepo.update(subscription, %{next_bill_date: next_bill_date})

      Map.update(acc, subscription.user, [subscription], &(&1 ++ [subscription]))
    end)
    |> Enum.map(fn {user, subscriptions} ->
      template = NotificationTemplate.create_daily_notification(user, subscriptions)

      case SubsNotificationRepo.create(user, subscriptions, template, dt) do
        {:ok, subs_notification} -> subs_notification
      end
    end)
  end
end

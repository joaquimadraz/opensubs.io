defmodule Subs.Application.DailyNotificationsBuilder do
  @moduledoc """
  This module is executed every midnight by cron.
  It gets all billable subscriptions from a day, updates it's next_bill_date
  and generates a notification to be delivered by the Notifier.

  TODO: Dunno. But I don't like this module.
  """
  alias Subs.{Subscription, SubscriptionRepo, SubsNotificationRepo}
  alias Subs.Domain.NotificationTemplate

  @dt Application.get_env(:subs, :dt)

  def build(dt \\ @dt) do
    now = dt.now()

    from = dt.beginning_of_day(now) |> dt.step_date(:days, 1)
    to = dt.end_of_day(now) |> dt.step_date(:days, 1)

    # TODO: Refactor. Try grouping from the DB?
    SubscriptionRepo.get_billable_subscriptions(from, to)
    |> Enum.reduce(%{}, fn subscription, acc ->
      {:ok, subscription} = move_next_bill_date!(subscription)
      Map.update(acc, subscription.user, [subscription], &(&1 ++ [subscription]))
    end)
    |> Enum.map(fn {user, subscriptions} ->
      template = NotificationTemplate.build(:daily, subscriptions)

      case SubsNotificationRepo.create(user, subscriptions, template, dt) do
        {:ok, subs_notification} -> subs_notification
      end
    end)
  end

  # next_bill_date calculation is outside notification create because we maybe not
  # want to send a notification for a particular subscription.
  defp move_next_bill_date!(subscription) do
    next_bill_date =
      @dt.step_date(subscription.next_bill_date, Subscription.cycle_step(subscription), 1)

    {:ok, _subscription} = SubscriptionRepo.update(subscription, %{next_bill_date: next_bill_date})
  end
end

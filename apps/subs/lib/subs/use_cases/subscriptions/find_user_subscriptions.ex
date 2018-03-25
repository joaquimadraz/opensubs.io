defmodule Subs.UseCases.Subscriptions.FindUserSubscriptions do
  @moduledoc false
  use Subs.UseCase
  alias Subs.SubscriptionRepo
  alias Subs.Application.SubscriptionsByMonth

  @dt Application.get_env(:subs, :dt)

  def perform(user, filters \\ %{}, dt \\ @dt) do
    subscriptions = SubscriptionRepo.get_user_subscriptions(user, filters)

    current_date =
      with {year, _} <- Integer.parse(filters["year_eq"] || ""),
           {month, _} <- Integer.parse(filters["month_eq"] || ""),
           {:ok, date} <- NaiveDateTime.new(year, month, 1, 0, 0, 0) do
        date
      else
        _ -> dt.now()
      end

    prev_month = dt.step_date(current_date, :months, -1)
    next_month = dt.step_date(current_date, :months, 1)

    month_subscriptions =
      SubscriptionsByMonth.filter(subscriptions, current_date.month, current_date.year)

    prev_month_subscriptions =
      SubscriptionsByMonth.filter(subscriptions, prev_month.month, prev_month.year)

    next_month_subscriptions =
      SubscriptionsByMonth.filter(subscriptions, next_month.month, next_month.year)

    ok!(%{
      subscriptions: filter_archived_subscriptions(subscriptions),
      month_stats: %{
        prev: %{
          payments: prev_month_subscriptions,
          total: sum_subcriptions_amounts(prev_month_subscriptions)
        },
        curr: %{
          payments: month_subscriptions,
          total: sum_subcriptions_amounts(month_subscriptions)
        },
        next: %{
          payments: next_month_subscriptions,
          total: sum_subcriptions_amounts(next_month_subscriptions)
        }
      }
    })
  end

  defp sum_subcriptions_amounts(subscriptions) do
    Enum.reduce(subscriptions, 0, fn sub, acc -> acc + sub.amount end)
  end

  defp filter_archived_subscriptions(subscriptions) do
    Enum.filter(subscriptions, fn subscription -> !subscription.archived end)
  end
end

defmodule Subs.UseCases.Subscriptions.FindUserSubscriptions do
  @moduledoc false
  use Subs.UseCase
  alias Subs.SubscriptionRepo
  alias Subs.Helpers.DT
  alias Subs.Application.SubscriptionsByMonth

  def perform(user, filters \\ %{}) do
    subscriptions = SubscriptionRepo.get_user_subscriptions(user, filters)
    year = filters["year_eq"] || DT.now().year
    month = filters["month_eq"] || DT.now().month

    {:ok, current_date} = NaiveDateTime.new(year, month, 1, 0, 0, 0)

    prev_month = DT.step_date(current_date, :months, -1)
    next_month = DT.step_date(current_date, :months, 1)

    month_subscriptions =
      SubscriptionsByMonth.filter(subscriptions, current_date.month, current_date.year)

    prev_month_subscriptions =
      SubscriptionsByMonth.filter(subscriptions, prev_month.month, prev_month.year)

    next_month_subscriptions =
      SubscriptionsByMonth.filter(subscriptions, next_month.month, next_month.year)

    ok!(%{
      subscriptions: subscriptions,
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
end

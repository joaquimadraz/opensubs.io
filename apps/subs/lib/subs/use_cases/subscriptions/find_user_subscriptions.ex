defmodule Subs.UseCases.Subscriptions.FindUserSubscriptions do
  @moduledoc false
  use Subs.UseCase
  alias Subs.SubscriptionRepo
  alias Subs.Helpers.DT
  alias Subs.Application.SubscriptionsByMonth

  def perform(user, filters \\ %{}) do
    subscriptions = SubscriptionRepo.get_user_subscriptions(user, filters)
    month_subscriptions = SubscriptionsByMonth.filter(subscriptions, DT.now().month, DT.now().year)

    ok!(%{subscriptions: subscriptions, month_stats: [
      payments: month_subscriptions,
      total: Enum.reduce(month_subscriptions, 0, fn (sub, acc) -> acc + sub.amount end)
    ]})
  end

end

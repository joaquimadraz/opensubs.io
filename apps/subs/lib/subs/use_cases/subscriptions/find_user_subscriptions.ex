defmodule Subs.UseCases.Subscriptions.FindUserSubscriptions do
  @moduledoc false
  use Subs.UseCase
  alias Subs.SubscriptionRepo

  def perform(user) do
    subscriptions = SubscriptionRepo.get_user_subscriptions(user)
    ok!(%{subscriptions: subscriptions})
  end
end

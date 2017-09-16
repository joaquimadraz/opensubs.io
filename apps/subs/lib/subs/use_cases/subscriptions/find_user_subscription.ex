defmodule Subs.UseCases.Subscriptions.FindUserSubscription do
  @moduledoc false
  use Subs.UseCase
  alias Subs.SubscriptionRepo

  def perform(user, subscription_id) do
    case SubscriptionRepo.get_user_subscription(user, subscription_id) do
      nil ->
        failure!(:not_found)
      subscription ->
        ok!(%{subscription: subscription})
    end
  end
end

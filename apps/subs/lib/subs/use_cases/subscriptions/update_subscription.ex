defmodule Subs.UseCases.Subscriptions.UpdateSubscription do
  @moduledoc false
  use Subs.UseCase
  alias Subs.SubscriptionRepo

  def perform(user, subscription_id, subscription_params) do
    with {:ok, subscription} <- find_subscription(user, subscription_id),
         {:ok, subscription} <- update_subscription(subscription, subscription_params) do
      ok!(%{subscription: subscription})
    else
      {:error, :invalid_params, changeset} ->
        failure!(:invalid_params, %{changeset: changeset})
      {:error, reason} ->
        failure!(reason)
    end
  end

  defp find_subscription(user, subscription_id) do
    case SubscriptionRepo.get_user_subscription(user, subscription_id) do
      nil -> {:error, :subscription_not_found}
      subscription -> {:ok, subscription}
    end
  end

  defp update_subscription(subscription, params) do
    case SubscriptionRepo.update(subscription, params) do
      {:ok, subscription} -> {:ok, subscription}
      {:error, changeset} -> {:error, :invalid_params, changeset}
    end
  end
end

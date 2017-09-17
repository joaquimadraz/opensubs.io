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
    params = consolidate_amount(params)

    case SubscriptionRepo.update(subscription, params) do
      {:ok, subscription} -> {:ok, subscription}
      {:error, changeset} -> {:error, :invalid_params, changeset}
    end
  end

  # FIXME: Move calculation to helper and consolidation to Subscription
  # Consolidates amount as integer value before storing on the database.
  # 1.99 (£) will be saved as 199
  # 7 (£) will be saved as 700
  defp consolidate_amount(params = %{"amount" => amount}) when is_binary(amount) do
    case Float.parse(amount) do
      :error -> params # skip consolidate, fails on changeset
      {parsed, _} -> do_consolidate_amount(%{params | "amount" => parsed})
    end
  end
  defp consolidate_amount(params = %{"amount" => _amount}) do
    do_consolidate_amount(params)
  end
  defp consolidate_amount(params), do: params

  defp do_consolidate_amount(params = %{"amount" => amount}) do
    %{params | "amount" => round(amount * 100.0)}
  end
end

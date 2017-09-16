defmodule Subs.UseCases.Subscriptions.CreateSubscription do
  @moduledoc false
  use Subs.UseCase
  alias Subs.SubscriptionRepo

  def perform(subscription_params) do
    with params <- consolidate_amount(subscription_params),
         {:ok, subscription} <- SubscriptionRepo.create(params) do
      ok!(%{subscription: subscription})
    else
      {:error, changeset} ->
        failure!(:invalid_params, %{changeset: changeset})
    end
  end

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

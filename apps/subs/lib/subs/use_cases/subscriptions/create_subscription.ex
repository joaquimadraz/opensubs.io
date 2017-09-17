defmodule Subs.UseCases.Subscriptions.CreateSubscription do
  @moduledoc false
  use Subs.UseCase
  alias Subs.SubscriptionRepo

  def perform(user, subscription_params) do
    case SubscriptionRepo.create_with_user(user, subscription_params) do
      {:ok, subscription} ->
        ok!(%{subscription: subscription})
      {:error, changeset} ->
        failure!(:invalid_params, %{changeset: changeset})
    end
  end
end

defmodule Subs.UseCases.Subscriptions.CreateSubscription do
  def perform(%{}), do: {:error, :missing_params}
end

defmodule SubsWeb.Api.SubscriptionView do
  use SubsWeb, :view
  alias SubsWeb.Api.SubscriptionView

  def render("index.json", %{subscriptions: subscriptions}) do
    %{
      data: render_many(subscriptions, SubscriptionView, "subscription.json"),
      meta: %{}
    }
  end

  def render("create.json", %{subscription: subscription}) do
    %{
      data: render_one(subscription, SubscriptionView, "subscription.json"),
      meta: %{}
    }
  end

  def render("subscription.json", %{subscription: subscription}) do
    %{
      id: subscription.id,
      name: subscription.name,
      description: subscription.description,
      amount: amount_to_human(subscription.amount),
      amount_currency: subscription.amount_currency,
      amount_currency_symbol: subscription.amount_currency_symbol,
      cycle: subscription.cycle,
      color: subscription.color,
      first_bill_date: naive_to_utc_iso8601(subscription.first_bill_date),
      next_bill_date: naive_to_utc_iso8601(subscription.next_bill_date),
    }
  end

  defp amount_to_human(amount), do: amount / 100

  defp naive_to_utc_iso8601(date) do
    DateTime.from_naive!(date, "Etc/UTC") |> DateTime.to_iso8601()
  end
end

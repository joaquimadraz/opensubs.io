defmodule SubsWeb.Api.SubscriptionView do
  use SubsWeb, :view
  alias Subs.Helpers.Money
  alias SubsWeb.Api.SubscriptionView

  def render("index.json", %{subscriptions: subscriptions}) do
    %{
      data: render_many(subscriptions, SubscriptionView, "subscription.json"),
      meta: %{
        avg: %{
          monthly: calculate_monthly_avg(subscriptions),
          yearly: calculate_yearly_avg(subscriptions),
        }
      }
    }
  end

  def render("created.json", %{subscription: subscription}) do
    %{
      data: render_one(subscription, SubscriptionView, "subscription.json"),
      meta: %{}
    }
  end

  def render("updated.json", %{subscription: subscription}) do
    %{
      data: render_one(subscription, SubscriptionView, "subscription.json"),
      meta: %{}
    }
  end

  def render("show.json", %{subscription: subscription}) do
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
      service_code: subscription.service_code,
    }
  end

  defp amount_to_human(amount), do: Money.to_human(amount)

  defp naive_to_utc_iso8601(date) do
    DateTime.from_naive!(date, "Etc/UTC") |> DateTime.to_iso8601()
  end

  # TODO: Refactor. Convert amounts to user currency
  defp calculate_monthly_avg(subscriptions) do
    monthly_subscriptions = Enum.filter(subscriptions, fn(subscription) -> subscription.cycle == "monthly" end)
    yearly_subscriptions = Enum.filter(subscriptions, fn(subscription) -> subscription.cycle == "yearly" end)

    montly_avg = Enum.reduce(monthly_subscriptions, 0.0, fn(subscription, acc) -> acc + subscription.amount end) * 1.0
    yearly_avg = Enum.reduce(yearly_subscriptions, 0.0, fn(subscription, acc) -> acc + subscription.amount / 12.0 end)

    Float.round(amount_to_human(montly_avg + yearly_avg), 2)
  end

  defp calculate_yearly_avg(subscriptions) do
    monthly_subscriptions = Enum.filter(subscriptions, fn(subscription) -> subscription.cycle == "monthly" end)
    yearly_subscriptions = Enum.filter(subscriptions, fn(subscription) -> subscription.cycle == "yearly" end)

    montly_avg = Enum.reduce(monthly_subscriptions, 0.0, fn(subscription, acc) -> acc + subscription.amount * 12.0 end)
    yearly_avg = Enum.reduce(yearly_subscriptions, 0.0, fn(subscription, acc) -> acc + subscription.amount end) * 1.0

    Float.round(amount_to_human(montly_avg + yearly_avg), 2)
  end
end

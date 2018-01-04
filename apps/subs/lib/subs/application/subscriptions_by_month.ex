defmodule Subs.Application.SubscriptionsByMonth do
  @moduledoc """
  Given a set of subscriptions, a month and a year, filter subcriptions that
  fit in that month/year.
  Subscription order comes from the DB.
  """
  alias Subs.Subscription

  @dt Application.get_env(:subs, :dt)

  def filter(subscriptions, month, year) do
    {:ok, target} = NaiveDateTime.new(year, month, 1, 0, 0, 0)
    target = Timex.end_of_month(target)

    subscriptions
    |> Enum.filter(fn subscription ->
      past_subscription?(subscription, target) &&
        (Subscription.monthly?(subscription) || yearly_on_current_month?(subscription, month))
    end)
    |> Enum.map(fn subscription ->
      step = if(subscription.cycle == "monthly", do: :months, else: :years)

      current_bill_date =
        @dt.calculate_current_bill_date(subscription.first_bill_date, step, target)

      %{subscription | current_bill_date: current_bill_date}
    end)
    |> Enum.sort_by(& &1.current_bill_date)
  end

  defp past_subscription?(subscription, target) do
    NaiveDateTime.diff(subscription.first_bill_date, target) <= 0
  end

  defp yearly_on_current_month?(subscription, month) do
    Subscription.yearly?(subscription) && subscription.first_bill_date.month == month
  end
end

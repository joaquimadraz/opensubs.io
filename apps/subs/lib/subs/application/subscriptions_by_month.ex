defmodule Subs.Application.SubscriptionsByMonth do
  @moduledoc """
  Given a set of subscriptions, a month and a year, filter subcriptions that
  fit in that month/year.
  """
  alias Subs.Helpers.DT

  def filter(subscriptions, month, year) do
    {:ok, target} = NaiveDateTime.new(year, month, 1, 0, 0, 0)
    target = Timex.end_of_month(target)

    data =
      subscriptions
      |> Enum.filter(fn sub ->
        NaiveDateTime.diff(sub.first_bill_date, target) <= 0
      end)
      |> Enum.reduce(%{monthly: [], yearly: []}, fn sub, acc ->
        case sub.cycle do
          "monthly" ->
            current_bill_date =
              DT.calculate_current_bill_date(
                sub.first_bill_date,
                :months,
                target
              )

            sub = %{sub | current_bill_date: current_bill_date}

            put_in(acc[:monthly], [sub | acc[:monthly]])

          "yearly" ->
            if sub.first_bill_date.month == month do
              current_bill_date =
                DT.calculate_current_bill_date(
                  sub.first_bill_date,
                  :years,
                  target
                )

              sub = %{sub | current_bill_date: current_bill_date}

              put_in(acc[:yearly], [sub | acc[:yearly]])
            else
              acc
            end
        end
      end)

    data[:yearly] ++ data[:monthly]
  end
end

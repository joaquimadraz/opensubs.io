defmodule Subs.Helpers.DT do
  @behaviour Subs.Helpers.DTHelper

  def now, do: NaiveDateTime.utc_now()

  def today_beginning_of_day do
    Timex.beginning_of_day(NaiveDateTime.utc_now())
  end

  def calculate_next_bill_date(from_date, step, until_date \\ today_beginning_of_day()) do
    if NaiveDateTime.diff(from_date, until_date) > 0 do
      from_date
    else
      from_date
      |> step_date(step, 1)
      |> calculate_next_bill_date(step, until_date)
    end
  end

  def step_date(from_date, :hours, hours), do: Timex.shift(from_date, hours: hours)
  def step_date(from_date, :months, months), do: Timex.shift(from_date, months: months)
  def step_date(from_date, :years, years), do: Timex.shift(from_date, years: years)
end

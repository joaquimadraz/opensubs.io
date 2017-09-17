defmodule Subs.Helpers.DT do
  @moduledoc false

  def today_beginning_of_day do
    Timex.beginning_of_day(NaiveDateTime.utc_now())
  end

  def calculate_next_bill_date(from_date, step, until_date \\ today_beginning_of_day()) do
    if NaiveDateTime.diff(from_date, until_date) > 0 do
      from_date
    else
      from_date
      |> step_date(step)
      |> calculate_next_bill_date(step, until_date)
    end
  end

  def step_date(from_date, :months), do: Timex.shift(from_date, months: 1)
  def step_date(from_date, :years), do: Timex.shift(from_date, years: 1)
end

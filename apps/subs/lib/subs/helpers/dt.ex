defmodule Subs.Helpers.DT do
  @behaviour Subs.Helpers.DTBehaviour

  def now, do: NaiveDateTime.utc_now()

  def today_beginning_of_day, do: beginning_of_day(now())

  def beginning_of_day(date), do: Timex.beginning_of_day(date)

  def end_of_day(date), do: Timex.end_of_day(date)

  def minutes_between(from_date, to_date) do
    Timex.diff(from_date, to_date, :minutes)
  end

  def strftime(date, format) do
    Timex.format!(date, format, :strftime)
  end

  # TODO: Rethink this.
  def calculate_next_bill_date(from_date, step, until_date \\ today_beginning_of_day()) do
    if NaiveDateTime.diff(from_date, until_date) > 0 do
      from_date
    else
      from_date
      |> step_date(step, 1)
      |> calculate_next_bill_date(step, until_date)
    end
  end

  def calculate_current_bill_date(from_date, step, until_date \\ today_beginning_of_day()) do
    diff =
      Timex.diff(Timex.beginning_of_month(from_date), Timex.beginning_of_month(until_date), step)

    if diff <= 0 do
      step_date(from_date, step, diff * -1)
    else
      from_date
    end
  end

  def step_date(from_date, :hours, hours), do: Timex.shift(from_date, hours: hours)
  def step_date(from_date, :days, days), do: Timex.shift(from_date, days: days)
  def step_date(from_date, :months, months), do: Timex.shift(from_date, months: months)
  def step_date(from_date, :years, years), do: Timex.shift(from_date, years: years)
end

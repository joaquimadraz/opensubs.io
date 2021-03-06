defmodule Subs.Test.Support.DTMock do
  @moduledoc false
  alias Subs.Helpers.DT

  defdelegate calculate_next_bill_date(from_date, step, until_date \\ today_beginning_of_day()), to: DT
  defdelegate calculate_current_bill_date(from_date, step, until_date), to: DT
  defdelegate step_date(from_date, step, hours), to: DT
  defdelegate minutes_between(from_date, to_date), to: DT
  defdelegate strftime(from_date, format), to: DT
  defdelegate beginning_of_day(date), to: DT
  defdelegate end_of_day(date), to: DT
  defdelegate end_of_week(date), to: DT
  defdelegate end_of_month(date), to: DT

  def now(), do: ~N[2017-08-06T09:00:00Z]

  def today_beginning_of_day(), do: ~N[2017-08-06T00:00:00Z]
end

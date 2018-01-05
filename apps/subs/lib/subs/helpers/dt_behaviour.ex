defmodule Subs.Helpers.DTBehaviour do
  @moduledoc """
  I've created this behaviour to be able to use mock it with mox.
  Still figuring out if this is the best approach.
  """

  @callback now() :: NaiveDatetime.t
  @callback beginning_of_day(NaiveDateTime.t) :: NaiveDateTime.t
  @callback end_of_day(NaiveDateTime.t) :: NaiveDateTime.t
  @callback today_beginning_of_day() :: NaiveDatetime.t
  @callback calculate_next_bill_date(NaiveDatetime.t, integer(), NaiveDatetime.t) :: NaiveDatetime.t
  @callback step_date(NaiveDatetime.t, atom(), integer()) :: NaiveDatetime.t
end

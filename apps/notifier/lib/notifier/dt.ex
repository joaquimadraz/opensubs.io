defmodule Notifier.DT do
  @behaviour Notifier.DTBehaviour

  def now, do: NaiveDateTime.utc_now()
end

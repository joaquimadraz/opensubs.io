defmodule Subs.Helpers.Money do
  @moduledoc false

  def consolidate(value), do: round(value * 100.0)

  def to_human(value), do: value / 100.0

  def to_human_formated(value, currency_symbol) do
    "#{currency_symbol} #{to_human(value)}"
  end
end

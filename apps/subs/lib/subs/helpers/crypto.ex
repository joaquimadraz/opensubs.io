defmodule Subs.Helpers.Crypto do
  def sha1(string) do
    :crypto.hash(:sha, string) |> Base.encode16()
  end
end

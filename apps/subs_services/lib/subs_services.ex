defmodule SubsServices do
  @moduledoc false
  alias SubsServices.Store

  def get_services, do: Store.get_services()

  def get_service(code), do: Store.get_service(code)
end

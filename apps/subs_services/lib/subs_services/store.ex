defmodule SubsServices.Store do
  use Agent

  def start_link do
    raw = File.read!("./services.json")
    data = Poison.decode!(raw)

    Agent.start_link(fn -> data end, name: __MODULE__)
  end

  def get_service(code) do
    Agent.get(__MODULE__, fn store ->
      store[code]
    end)
  end
end

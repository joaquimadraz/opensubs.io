defmodule SubsServices.Store do
  use Agent

  def start_link(file_path) do
    data = read_from_file!(file_path)

    Agent.start_link(fn -> data end, name: __MODULE__)
  end

  def get_services do
    Agent.get(__MODULE__, fn store ->
      Map.values(store)
    end)
  end

  def get_service(code) do
    Agent.get(__MODULE__, fn store ->
      store[code]
    end)
  end

  defp read_from_file!(file_path) do
    file_path |> File.read!() |> Poison.decode!()
  end
end

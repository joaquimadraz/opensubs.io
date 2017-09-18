defmodule SubsServices.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      worker(SubsServices.Store, ["services.json"])
    ], strategy: :one_for_one, name: SubsServices.Supervisor)
  end
end

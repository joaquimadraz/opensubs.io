defmodule Subs.Application do
  @moduledoc """
  The Subs Application Service.

  The subs system business domain lives in this application.

  Exposes API to clients such as the `SubsWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Subs.Repo, []),
    ], strategy: :one_for_one, name: Subs.Supervisor)
  end
end

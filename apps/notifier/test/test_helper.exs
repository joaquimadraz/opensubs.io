ExUnit.start(exclude: [:skip])
{:ok, _} = Application.ensure_all_started(:ex_machina)
Ecto.Adapters.SQL.Sandbox.mode(Notifier.Repo, :manual)

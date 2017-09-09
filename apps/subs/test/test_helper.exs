ExUnit.start(exclude: [:skip, :integration])
{:ok, _} = Application.ensure_all_started(:ex_machina)
Ecto.Adapters.SQL.Sandbox.mode(Subs.Repo, :manual)

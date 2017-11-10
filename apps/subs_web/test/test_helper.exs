ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Subs.Repo, :manual)

Application.put_env(:wallaby, :base_url, SubsWeb.Endpoint.url)

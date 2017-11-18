ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Subs.Repo, :manual)

System.cmd("sh", ["priv/build_frontend.sh"])

Application.put_env(:wallaby, :base_url, SubsWeb.Endpoint.url)
Application.get_env(:wallaby, :max_wait_time, 5_000)

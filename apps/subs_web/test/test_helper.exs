ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Subs.Repo, :manual)

System.cmd("sh", ["priv/build_frontend.sh"])

Application.put_env(:wallaby, :base_url, SubsWeb.Endpoint.url)
Application.put_env(:wallaby, :chrome, [
  headless: System.get_env("HEADLESS_ACCEPTANCE") == "true", do: true, else: false
])

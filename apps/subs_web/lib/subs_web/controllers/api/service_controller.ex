defmodule SubsWeb.Api.ServiceController do
  use SubsWeb, :controller

  @subs_services Application.get_env(:subs_web, :subs_services)

  def index(conn, _params) do
    services = @subs_services.get_services()

    conn
    |> put_status(:ok)
    |> render("index.json", services: services)
  end
end

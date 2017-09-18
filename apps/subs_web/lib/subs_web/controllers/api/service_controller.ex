defmodule SubsWeb.Api.ServiceController do
  use SubsWeb, :controller
  alias SubsServices.Store

  def index(conn, _params) do
    services = SubsServices.Store.get_services()

    conn
    |> put_status(:ok)
    |> render("index.json", services: services)
  end
end

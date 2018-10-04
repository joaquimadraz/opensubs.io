defmodule SubsWeb.PageController do
  use SubsWeb, :controller

  def index(conn, _params) do
    # Debug
    render(conn, "index.html")
  end

  def ping(conn, _params) do
    send_resp(conn, 200, "mate...")
  end
end

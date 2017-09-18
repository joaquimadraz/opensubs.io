defmodule SubsWeb.Api.ServiceView do
  use SubsWeb, :view
  alias SubsWeb.Api.ServiceView

  def render("index.json", %{services: services}) do
    %{
      data: render_many(services, ServiceView, "service.json"),
      meta: %{}
    }
  end

  def render("service.json", %{service: service}) do
    %{
      code: service["code"],
      name: service["name"],
      color: service["color"]
    }
  end
end
